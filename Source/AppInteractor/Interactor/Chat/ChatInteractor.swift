//
//  ChatInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import RxCocoa
import RxSwift

public final class ChatInteractor {
    
    public static let shared = ChatInteractor()
    
    public init() {}
    
    public func getUser(userId: String) -> Single<User> {
        return API.User.Get(userId: userId).asSingle()
    }
}
