//
//  ProfileImage.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class ProfileImage: Object {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var image: Data = .init()
    @objc public dynamic var filePath: String = ""

    @objc public dynamic var user: User?
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
