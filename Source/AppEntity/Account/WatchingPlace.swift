//
//  WatchingPlace.swift
//  AppRequest
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class WatchingPlace: Object, Decodable {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var name: String = ""
    @objc public dynamic var userId: String = ""
    @objc public dynamic var createdAt: Date = .init()
    @objc public dynamic var updatedAt: Date = .init()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.updatedAt = try container.decodeDate(forKey: .updatedAt)
    }
}
