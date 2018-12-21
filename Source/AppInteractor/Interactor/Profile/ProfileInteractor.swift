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
    
    public func updateProfileInfo(params: [String: Any]) -> Single<Void> {
        
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
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
