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
    
    public func activatedUser() -> Single<Me> {
        return SharedDBManager.activatedAccount()
            .map { $0.objects(Me.self).first }
            .asObservable()
            .filterNil()
            .asSingle()
    }
    
    public func nearbyFriends() -> Single<[User]> {
        
        return self.activatedUser()
            .flatMap {
                API.User.GetNearbyFriends(userId: $0.id).asSingle()
            }
    }
}
