//
//  DBManager.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/30.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift

public final class DBManager {
    
    private let database: Realm
    public static let shared = DBManager()

    private init() {
        self.database = try! Realm()
    }
    
    public func getDataFromDB() -> Results<Object> {
    
        let results: Results<Object> = self.database.objects(Item.self)
    }
}
