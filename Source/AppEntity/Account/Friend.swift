//
//  Friend.swift
//  AppEntity
//
//  Created by 服部穣 on 2019/02/14.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import RealmSwift

public final class Friend: Object, Decodable {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var userId: String = ""
    @objc public dynamic var friendUserId: String = ""
    @objc public dynamic var relationStatus: String = ""
    @objc public dynamic var createdAt: Date = .init()
    @objc public dynamic var updatedAt: Date = .init()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case userId = "user_id"
        case friendUserId = "friend_user_id"
        case relationStatus = "relation_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.friendUserId = try container.decode(String.self, forKey: .friendUserId)
        self.relationStatus = try container.decode(String.self, forKey: .relationStatus)
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.updatedAt = try container.decodeDate(forKey: .updatedAt)
    }
}
