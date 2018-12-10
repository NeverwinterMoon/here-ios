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

public final class WelcomeInteractor {
    
    public static let shared = WelcomeInteractor()
    
    public init() {}
    
    public func login(usernameOrEmail: String, password: String) -> Single<Void> {
        
        return API.Login.Get(usernameOrEmail: usernameOrEmail, password: password).asSingle()
            .flatMap { user -> Single<Void> in
                let account = Account()
                account.id = user.id
                account.username = user.username
                account.emailAddress = user.emailAddress

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
                    }
                    return Disposables.create()
                }
            }
    }
    
    public func sendEmail(emailAddress: String) {
        
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
