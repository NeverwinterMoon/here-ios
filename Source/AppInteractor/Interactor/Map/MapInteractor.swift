//
//  MapInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppEntity
import AppRequest
import RxCocoa
import RxSwift
import RxOptional

public final class MapInteractor {
    
    public static let shared = MapInteractor()
    
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
    
    public func nearbyFriends() -> Single<[User]> {
        
        return Single.just([])
        // TODO: implement
//        return self.activatedUser()
//            .flatMap { me -> Single<[User]> in
//                guard let me = me else {
//                    return Single.just([])
//                }
//                return API.User.GetNearbyFriends(username: me.id).asSingle()
//            }
    }
}
