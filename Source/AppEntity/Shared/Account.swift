//
//  Account.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/12/01.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class Account: Object {
    
    @objc public dynamic var id: String = ""
    @objc public dynamic var isDefaultAccount: Bool = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
