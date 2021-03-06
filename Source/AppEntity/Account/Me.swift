//
//  Me.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import RealmSwift

public final class Me: Object, Decodable {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var email: String = ""
    @objc public dynamic var username: String = ""
    @objc public dynamic var userDisplayName: String = ""
    @objc public dynamic var profileImageURL: String? = ""
    @objc public dynamic var selfIntroduction: String? = ""
    @objc public dynamic var createdAt: Date = .init()
    @objc public dynamic var updatedAt: Date = .init()
    
    public override static func primaryKey() -> String? {
        
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case email = "email"
        case username
        case userDisplayName = "user_display_name"
        case profileImageURL = "profile_image_url"
        case selfIntroduction = "self_introduction"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        self.userDisplayName = try container.decode(String.self, forKey: .userDisplayName)
        self.profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        self.selfIntroduction = try container.decodeIfPresent(String.self, forKey: .selfIntroduction)
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.updatedAt = try container.decodeDate(forKey: .updatedAt)
    }
}

