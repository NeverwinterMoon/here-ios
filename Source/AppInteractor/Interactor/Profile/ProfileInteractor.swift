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
    
    public func activatedUser() -> Single<Me> {
        return SharedDBManager.activatedAccount()
            .map { $0.objects(Me.self).first }
            .asObservable()
            .filterNil()
            .asSingle()
    }
    
    public func user(username: String) -> Single<User> {
        return API.User.Get(username: username).asSingle()
    }

    public func friends() -> Single<[User]> {
        return activatedUser()
            .flatMap {
                API.User.GetFriends(username: $0.id).asSingle()
            }
    }
}
