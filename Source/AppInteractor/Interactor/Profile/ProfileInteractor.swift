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

public final class ProfileInteractor {
    
    public static let shared = ProfileInteractor()
    
    public init() {}
    
    public func user(userId: String) -> Single<User> {
        return API.User.Get(userId: userId).asSingle()
    }
    
    public func friendsOf(userId: String) -> Single<[User]> {
        return API.User.GetFriends(userId: userId).asSingle()
    }
}
