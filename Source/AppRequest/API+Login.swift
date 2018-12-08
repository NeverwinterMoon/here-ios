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
            
            public typealias ElementType = Bool
            
            public let path = "/login"
            public let parameters: [String: Any]
            
            public init(username: String, password: String) {
                self.parameters = ["username": username, "password": password]
            }
        }
    }
}
