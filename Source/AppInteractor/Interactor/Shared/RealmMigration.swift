//
//  RealmMigration.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/15.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmMigration {
    
    public let shared = RealmMigration()
    
    private init() {}
    
    public enum SchemaVersion: UInt64 {
        case v1 = 1
        
        static let latestVersion: SchemaVersion = .v1
    }
}
