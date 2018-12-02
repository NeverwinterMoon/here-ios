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
    
    public func getDataFromDB<Item: Object>() -> Results<Item> {
    
        let results: Results<Item> = self.database.objects(Item.self)
        return results
    }
}
