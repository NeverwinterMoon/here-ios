//
//  WelcomeInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppRequest
import RxCocoa
import RxSwift

public final class WelcomeInteractor {
    
    public static let shared = WelcomeInteractor()
    
    public init() {}
    
    public func validLogin(username: String, password: String) -> Single<Bool> {
        
        return API.Login.Get(username: username, password: password).asSingle()
    }
    
    public func sendEmail(emailAddress: String) {
        
    }
}
