//
//  SharedDBMaganer.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/01.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RealmSwift
import RxCocoa
import RxSwift
import RxOptional

public final class SharedDBManager {
    
    static func shared() -> Realm {
        return try! Realm(configuration: sharedConfig)
    }
    
    static func activatedAccountRealm() -> Single<Realm?> {
        
        let defaultAccount = shared().objects(Account.self).filter("isDefaultAccount == true")
        guard let first = defaultAccount.first else {
            assertionFailure("when login, isDefaultAccount should be set to true for at least one account")
            return Single.just(nil)
        }

        let config = accountConfig(userId: first.id)
        let realm = try! Realm(configuration: config)
        return Single.just(realm)
    }

    static var loggedInUserIds: BehaviorRelay<[String]> {
        
        let relay = BehaviorRelay<[String]>.init(value: [])
        let accounts = shared().objects(Account.self)
        
        let ids: [String] = accounts.map { account in account.id }
        relay.accept(ids)
        return relay
    }

    public static func setDefaultRealmForUser(userId: String) {
        
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(userId).realm")
        config.objectTypes = [
            User.self
        ]
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Private
    private static let sharedConfig: Realm.Configuration = {
        var sharedConfig = Realm.Configuration()
        sharedConfig.fileURL = sharedConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("shared.realm")
        sharedConfig.objectTypes = [
            Account.self
        ]
        print("debug path for shared")
        print(sharedConfig.fileURL)
        sharedConfig.schemaVersion = RealmMigration.SchemaVersion.latestVersion.rawValue
        return sharedConfig
    }()
    
    private static func accountConfig(userId: String) -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(userId).realm")
        config.objectTypes = [
            User.self
        ]
        //        TODO: version
        config.schemaVersion = RealmMigration.SchemaVersion.latestVersion.rawValue
        return config
    }
}
