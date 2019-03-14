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
import CoreLocation
import RxCocoa
import RxSwift
import RxOptional

public final class MapInteractor {
    
    public static let shared = MapInteractor()
    
    public init() {}
    
    public func activatedUser() -> Single<User> {
        return SharedDBManager.activatedAccountRealm()
            .map { accountRealm -> User? in
                guard let realm = accountRealm else {
                    return nil
                }
                return realm.objects(User.self).first
            }
            .asObservable()
            .filterNil()
            .asSingle()
    }
    
    public func getNearbyFriends() -> Single<[User]> {
        return self.activatedUser()
            .flatMap {
                API.User.GetNearbyFriends(username: $0.id).asSingle()
            }
    }
    
    public func getNearSpotFriends() -> Single<(String, [User])> {
        return Single.just(("", []))
    }
    
    public func updateLocation(location: CLLocationCoordinate2D) -> Single<Void> {
        return self.activatedUser()
            .flatMap { user -> Single<User> in
                let params: [String: Any] = ["location": [location.latitude, location.longitude]]
                return API.User.Update(userId: user.id, params: params).asSingle()
            }
            .map { _ in }
    }
}
