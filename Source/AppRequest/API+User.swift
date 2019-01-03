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
            
            public typealias ElementType = AppEntity.User

            public let path: String
            public let parameters: [String: Any] = [:]

            public init(userId: String) {
                self.path = "users/\(userId)"
            }
        }
        
        public struct GetFriends: GETTargetType {
            
            public typealias ElementType = [AppEntity.User]
            
            public let path: String
            public let parameters: [String: Any] = [:]
            
            public init(username: String) {
                self.path = "users/\(username)/friends"
            }
        }
        
        public struct GetNearbyFriends: GETTargetType {
            
            public typealias ElementType = [AppEntity.User]
            
            public let path: String
            public let parameters: [String: Any] = [:]
            
            public init(username: String) {
                self.path = "users/\(username)/nearby_friends"
            }
        }
        
        public struct GetAllUsers: GETTargetType {
            
            public typealias ElementType = [AppEntity.User]
            
            public let path: String
            public let parameters: [String : Any] = [:]
            
            public init() {
                self.path = "users"
            }
        }
        
        public struct Create: POSTTargetType {
            
            public typealias ElementType = AppEntity.User

            public let path: String
            public let parameters: [String: Any]
            
            public init(email: String, username: String, password: String) {
                self.path = "users"
                self.parameters = ["email": email, "username": username, "password": password]
            }
        }
        
        public struct SendFriendRequest: POSTTargetType {
            
            public typealias ElementType = AppEntity.FriendPending
            
            public let path: String
            public let parameters: [String : Any]
            
            public init(userId: String, toUserId: String) {
                self.path = "users/\(userId)/friend_pendings"
                self.parameters = ["with_user_id": toUserId]
            }
        }
        
        public struct Update: PATCHTargetType {
            
            public typealias ElementType = AppEntity.User
            
            public let path: String
            public let parameters: [String: Any]
            
            public init(userId: String, params: [String: Any]) {
                self.path = "users/\(userId)"
                self.parameters = params
            }
        }
    }
}
