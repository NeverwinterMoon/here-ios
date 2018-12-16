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
import RxCocoa
import RxSwift
import RxOptional

public final class ProfileInteractor {
    
    public static let shared = ProfileInteractor()
    
    public init() {}
    
    public func activatedUser() -> Single<User?> {
        return SharedDBManager.activatedAccountRealm()
            .map { accountRealm -> User? in
                accountRealm.objects(User.self).first
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
}
