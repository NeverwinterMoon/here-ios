//
//  API+Login.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import Moya

extension API {
    
    public enum Login {
        
        public struct Get: GETTargetType {
            
            public typealias ElementType = AppEntity.User
            
            public let path = "/login"
            public let parameters: [String: Any]
            
            public init(usernameOrEmail: String, password: String) {
                // TODO: ゆくゆくはusernameでもemailでも行けるようにする。dripにはusername_or_emailみたいなパラメータで渡す
                self.parameters = ["email": usernameOrEmail, "password": password]
            }
        }
    }
}
