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
            
            public typealias ElementType = AccountInfo
            
            public let path = "/login"
            public let parameters: [String: Any]
            
            public init(usernameOrEmail: String, password: String) {
                self.parameters = ["username_or_email": usernameOrEmail, "password": password]
            }
            
            public struct AccountInfo: Decodable {
                public let username: String
                public let email: String
                public let password: String
            }
        }
    }
}
