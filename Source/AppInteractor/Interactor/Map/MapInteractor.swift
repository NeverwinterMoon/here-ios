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

public final class MapInteractor {
    
    public static let shared = MapInteractor()
    
    public init() {}

    public func nearbyFriends() -> Single<[User]> {
        
        return API.User.GetNearbyFriends().asSingle()
    }
}
