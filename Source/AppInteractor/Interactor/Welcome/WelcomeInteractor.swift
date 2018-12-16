//
//  WelcomeInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import RxCocoa
import RxSwift
import RealmSwift

public final class WelcomeInteractor {
    
    public static let shared = WelcomeInteractor()
    
    public init() {}
    
    public func login(usernameOrEmail: String, password: String) -> Single<Void> {
        
        return API.Login.Get(usernameOrEmail: usernameOrEmail, password: password).asSingle()
            .flatMap { user -> Single<Void> in

                let sharedAccounts = SharedDBManager.shared().objects(Account.self)
                sharedAccounts.forEach {
                    $0.isDefaultAccount = false
                }
                
                let account = Account()
                account.do {
                    $0.id = user.id
                    $0.email = user.email
                    $0.username = user.username
                    $0.userDisplayName = user.userDisplayName
                    $0.selfIntroduction = user.selfIntroduction
                    $0.isDefaultAccount = true
                }

                return Single<Void>.create { single -> Disposable in
                    do {
                        let sharedRealm = SharedDBManager.shared()
                        try sharedRealm.write {
                            sharedRealm.add(account)
                        }
                        SharedDBManager.setDefaultRealmForUser(userId: account.id)
                        print(Realm.Configuration.defaultConfiguration)
                        let defaultRealm = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
                        try defaultRealm.write {
                            defaultRealm.add(user)
                        }
                        single(.success(()))
                    } catch let error {
                        single(.error(error))
                        assertionFailure("error when writing to realm: \(error)")
                    }
                    return Disposables.create()
                }
            }
    }
    
    public func sendEmail(email: String, username: String, password: String) -> Single<Void> {
        
        return API.User.Create(email: email, username: username, password: password).asSingle()
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
