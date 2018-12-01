//
//  API+Me.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import Moya

extension API {
    
    public enum Me {
        
        public struct Get: GETTargetType {
            
            public typealias ElementType = AppEntity.Me
            
            public let path = "/me"
            public let parameters: [String: Any] = [:]
            
            public init() {}
        }
    }
}
