//
//  API+User.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import Moya

extension API {
    
    public enum User {
        
        public struct Get: GETTargetType {
            
            public typealias ElementType = User

            public let path: String
            public let parameters: [String: Any] = [:]

            public init(userId: String) {
                self.path = "users/\(userId)"
            }
        }
    }
}
