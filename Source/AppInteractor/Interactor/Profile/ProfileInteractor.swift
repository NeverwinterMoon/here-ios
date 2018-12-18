//
//  ProfileInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import RealmSwift
import RxCocoa
import RxSwift
import RxOptional

public final class ProfileInteractor {
    
    public static let shared = ProfileInteractor()
    
    public init() {}
    
    public func activatedUser() -> Single<User?> {
        return SharedDBManager.activatedAccountRealm()
            .map { accountRealm -> User? in
                guard let realm = accountRealm else {
                    return nil
                }
                return realm.objects(User.self).first
            }
            .asObservable()
            .asSingle()
    }
    
    public func user(username: String) -> Single<User> {
        return API.User.Get(username: username).asSingle()
    }

    public func friends() -> Single<[User]> {
        return self.activatedUser()
            .flatMap { me -> Single<[User]> in
                guard let me = me else {
                    return Single.just([])
                }
                return API.User.GetFriends(username: me.id).asSingle()
            }
    }
    
    public func updateProfileInfo(params: [String: Any]) -> Single<Void> {
        
        return SharedDBManager.activatedAccountRealm().map { realm in
            guard let realm = realm, let user = realm.objects(User.self).first else {
                assertionFailure()
                return
            }
            let userId = user.id
            let _ = API.User.Update(userId: userId, params: params).asSingle().map { user in
                do {
                    try realm.write {
                        realm.add(user, update: true)
                    }
                } catch let error {
                    assertionFailure("\(error)")
                }
            }
            return
        }
    }
}
