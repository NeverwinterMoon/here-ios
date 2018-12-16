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
                let account: Account = Account()
                account.id = user.id
                account.username = user.username
                account.email = user.email

                return Single<Void>.create { single -> Disposable in
                    do {
                        let realm = SharedDBManager.shared()
                        try realm.write {
                            realm.add(account)
                        }
                        SharedDBManager.setDefaultRealmForUser(userId: account.id)
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
