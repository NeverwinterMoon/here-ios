//
//  FriendPending.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/12/27.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class FriendPending: Object, Decodable {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var userId: String = ""
    @objc public dynamic var withUserId: String = ""
    @objc public dynamic var createdAt: Date = .init()
    @objc public dynamic var updatedAt: Date = .init()
    
    public override static func primaryKey() -> String? {
        
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case userId = "user_id"
        case withUserId = "with_user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.withUserId = try container.decode(String.self, forKey: .withUserId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
