//
//  ProfileInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppExtensions
import AppRequest
import RealmSwift
import RxCocoa
import RxSwift
import RxOptional

public final class ProfileInteractor {
    
    public static let shared = ProfileInteractor()
    
    public init() {}
    
    public func activatedUser() -> Single<User> {
        return SharedDBManager.activatedAccountRealm()
            .map { realm -> User in
                return realm!.objects(User.self).first!
            }
            .asObservable()
            .asSingle()
    }
    
    public func usersWithPrefix(of prefix: String) -> Single<[User]> {
        
        return API.User.GetUsersWithPrefix(of: prefix).asSingle()
    }

    public func friends() -> Single<[User]> {
        return self.activatedUser()
            .flatMap { me -> Single<[User]> in
                API.User.GetFriends(username: me.id).asSingle()
            }
    }
    
    public func approveRequest(userId: String) -> Single<Void> {
        return self.activatedUser()
            .flatMap { me -> Single<Friend> in
                FirebaseFriendsManager.shared.uploadFriendIds()
                return API.User.ApproveFriendRequest(userId: me.id, approvedUserId: userId).asSingle()
            }
            .map { _ in }
    }
    
    public func declineRequest(userId: String) -> Single<Void> {
        return self.activatedUser()
            .flatMap { me -> Single<Void> in
                API.User.DeleteFriendRequest(from: userId, to: me.id).asSingle()
            }
    }
    
    public func friendRequest(to userId: String) {
        self.activatedUser().flatMap {
            API.User.SendFriendRequest(userId: $0.id, toUserId: userId).asSingle()
        }
        .subscribe()
        .disposed(by: self.disposeBag)
    }
    
    public func cancelRequest(to userId: String) {
        self.activatedUser()
            .flatMap { me -> Single<Void> in
                API.User.DeleteFriendRequest(from: me.id, to: userId).asSingle()
            }
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    public func requestsOfUser(userId: String) -> Single<[FriendPending]> {
        return API.User.GetRequestsOfUser(userId: userId).asSingle()
    }
    
    public func getRelationWith(userId: String) -> Observable<RelationState> {
        return activatedUser().map { $0.id }
            .asObservable()
            .flatMap { [unowned self] in
                Observable.zip(
                    self.friends().asObservable(),
                    self.requestsOfUser(userId: $0).asObservable(),
                    self.requestsOfUser(userId: userId).asObservable(),
                    self.activatedUser().map { $0.id }.asObservable()
                )
            }
            .map { (friends, requestingsOfSelf, requestingsOfUser, activatedId) -> RelationState in
                if friends.first(where: { $0.id == userId }) != nil {
                    return .friend
                } else if requestingsOfSelf.first(where: { $0.withUserId == userId }) != nil {
                    return .requesting
                } else if requestingsOfUser.first(where: { $0.withUserId == activatedId }) != nil {
                    return .requested
                } else {
                    return .notFriend
                }
            }
    }
    
    public func getUser(userId: String) -> Single<User> {
        return API.User.Get(userId: userId).asSingle()
    }
    
//    public func blockingUsers(of userId: String) -> Single<User> {
//        return
//    }
    
    public func updateProfile(params: [String: Any]) -> Single<Void> {
        
        return SharedDBManager.activatedAccountRealm()
            .flatMap { realm in
                
                guard let realm = realm, let user = realm.objects(User.self).first else {
                    assertionFailure()
                    return Single.just(())
                }
                let userId = user.id
                return API.User.Update(userId: userId, params: params).asSingle().map { user in
                    do {
                        try realm.write {
                            realm.add(user, update: true)
                        }
                    } catch let error {
                        assertionFailure("\(error)")
                    }
                }
            }
    }

    public func updateProfileImage(image: UIImage, filePath: String) {
        
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        SharedDBManager.activatedAccountRealm()
            .map { realm in
                guard let realm = realm, let user = realm.objects(User.self).first else {
                    assertionFailure()
                    return
                }
                
                do {
                    let profileImage = ProfileImage()
                    profileImage.do {
                        $0.user = user
                        $0.image = data
                        $0.filePath = filePath
                    }

                    try realm.write {
                        
                        if let pi = realm.objects(ProfileImage.self).first {
                            realm.delete(pi)
                        }
                        realm.add(profileImage)
                    }
                } catch let error {
                    assertionFailure("\(error)")
                }
            }
            .asObservable()
            .flatMap {
                self.activatedUser().map { $0.id }
            }
            .flatMap {
                FirebaseStorageManager.uploadFile(data, userId: $0, fileName: filePath, ext: .jpeg)
            }
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    public func getSelfProfileImage() -> Single<UIImage> {
        
        return SharedDBManager.activatedAccountRealm()
            .map { realm in
                if let realm = realm, let profileImage = realm.objects(ProfileImage.self).first {
                    return UIImage(data: profileImage.image)!
                }
                return UIImage(named: "first")!
            }
    }

    public func getProfileIcon(filePath: String) -> Single<UIImage> {
        
        return FirebaseStorageManager.downloadFile(filePath: filePath).map { data -> UIImage in
            
            guard let data = data else {
                return UIImage(named: "first")!
            }
            return UIImage(data: data)!
        }
    }
    
    public func requestsReceiving() -> Single<[User]> {
        return self.activatedUser().flatMap {
            API.User.GetFriendRequests(userId: $0.id).asSingle()
        }
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}

public enum RelationState {
    case friend
    case notFriend
    case requesting
    case requested
    case blocking
    case blocked
}
