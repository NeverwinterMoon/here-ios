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
    
    static func activatedAccount() -> Single<Realm> {
        
        return self.activatedUserId
            .filterNil()
            .take(1)
            .map { try! Realm(configuration: accountConfig(userId: $0)) }
            .asSingle()
    }

    static let activatedUserId = BehaviorRelay<String?>(value: nil)
    static let loggedIdUserId = BehaviorRelay<[String]>(value: [])

    public func setDefaultRealmForUser(userId: String) {
        
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(userId).realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Private
    private static let sharedConfig: Realm.Configuration = {
        var sharedConfig = Realm.Configuration()
        sharedConfig.fileURL = sharedConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("shared.realm")
        sharedConfig.objectTypes = [Account.self]
        sharedConfig.readOnly = true
        //        TODO: version
        //        sharedConfig.schemaVersion =
        return sharedConfig
    }()
    
    private static func accountConfig(userId: String) -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(userId).realm")
        config.objectTypes = [
            User.self,
            Me.self
        ]
        config.readOnly = true
        //        TODO: version
        //        sharedConfig.schemaVersion =
        return config
    }
}
