//
//  API+WatchingPlaces.swift
//  AppRequest
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity

extension API {
    
    public enum WatchingPlaces {
        
        public struct Get: GETTargetType {
            
            public typealias ElementType = [AppEntity.WatchingPlace]

            public let path: String
            public let parameters: [String: Any] = [:]
            
            public init(userId: String) {
                self.path = "users/\(userId)/watching_places"
            }
        }
    }
}
