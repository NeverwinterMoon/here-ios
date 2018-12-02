//
//  Device.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/12/01.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class Device: Object {
    let accounts = List<Account>()
}

public final class Account: Object {
    @objc public dynamic var userId: String = ""
    @objc public dynamic var email: String = ""
}
