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
    
    public func user(userId: String) {
        return API.User.Get(userId: userId).asSingle().flatMap { user -> Single<Void> in
            
            SharedDBManager.activatedAccountRealm().map { realm  in
                guard let realm = realm else {
                    return
                }
                try realm.write {
                    realm.add(user, update: true)
                }
            }
        }
        .subscribe()
        .disposed(by: self.disposeBag)
    }

    public func friends() -> Single<[User]> {
        return self.activatedUser()
            .flatMap { me -> Single<[User]> in
                return API.User.GetFriends(username: me.id).asSingle()
            }
    }
    
    public func friendRequest(to userId: String) -> Single<Void> {
        return self.activatedUser().flatMap {
            API.User.SendFriendRequest(userId: $0.id, toUserId: userId).asSingle()
        }
        .map { _ in }
    }
    
    public func cancelRequest(to userId: String) -> Single<Void> {
        return self.activatedUser().flatMap {
            API.User.CancelFriendRequest(userId: $0.id, toUserId: userId).asSingle()
        }
        .map { _ in }
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
            .flatMap { _ -> Single<Void> in
                FirebaseStorageManager.uploadFile(data, filePath: filePath, ext: .jpeg)
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
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
