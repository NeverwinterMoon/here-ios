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
        
        public struct Get: AppTargetType {
            
            public typealias ObjectType = User
            
            public let path: String
            public let method: Moya.Method = .get
            public let parameters: [String: Any] = [:]
            public let parameterEncoding: ParameterEncoding = URLEncoding.default
            
            public init(userId: String) {
                self.path = "users/\(userId)"
            }
        }
    }
}
