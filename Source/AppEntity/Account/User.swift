//
//  User.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class User: Object, Decodable {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var emailAddress: String = ""
    @objc public dynamic var profileImageURL: String = ""
    @objc public dynamic var profileIntro: String = ""
    @objc public dynamic var friendsCount: Int = 0
    @objc public dynamic var createdAt: Date = .init()
    @objc public dynamic var updatedAt: Date = .init()
    
    public override static func primaryKey() -> String? {
        
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case emailAddress = "email_address"
        case profileImageURL = "profile_image_url"
        case profileIntro = "profile_intro"
        case friendsCount = "friends_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.emailAddress = try container.decode(String.self, forKey: .emailAddress)
        self.profileImageURL = try container.decode(String.self, forKey: .profileImageURL)
        self.profileIntro = try container.decode(String.self, forKey: .profileIntro)
        self.friendsCount = try container.decode(Int.self, forKey: .friendsCount)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
