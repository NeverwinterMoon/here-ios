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
import FirebaseAuth
import RxCocoa
import RxSwift
import RealmSwift

public final class WelcomeInteractor {
    
    public static let shared = WelcomeInteractor()
    
    public init() {}
    
    public func login(usernameOrEmail: String, password: String) -> Single<Void> {
        
        return API.Login.Get(usernameOrEmail: usernameOrEmail, password: password).asSingle()
            .flatMap { user -> Single<Void> in

                self.signInFirebaseAuth(email: user.email, password: password)
                return self.storeUserToRealm(user: user)
            }
    }
    
    public func sendEmail(email: String, username: String, password: String) -> Single<Void> {
        
        return self.createFirebaseAuth(email: email, password: password)
            .flatMap {
                API.User.Create(email: email, username: username, password: password).asSingle()
            }
            .flatMap {
                self.storeUserToRealm(user: $0)
            }
    }

    // MARK: - Private
    private let disposeBag = DisposeBag()
    
    private func storeUserToRealm(user: AppEntity.User) -> Single<Void> {
        
        let sharedAccounts = SharedDBManager.shared().objects(Account.self)
        sharedAccounts.forEach {
            $0.isDefaultAccount = false
        }
        
        let account = Account()
        account.do {
            $0.id = user.id
            $0.isDefaultAccount = true
        }
        
        return Single<Void>.create { single -> Disposable in
            do {
                let sharedRealm = SharedDBManager.shared()
                try sharedRealm.write {
                    sharedRealm.add(account)
                }
                SharedDBManager.setDefaultRealmForUser(userId: account.id)
                let defaultRealm = try Realm(configuration: Realm.Configuration.defaultConfiguration)
                try defaultRealm.write {
                    defaultRealm.add(user)
                }
                single(.success(()))
            } catch let error {
                single(.error(error))
                assertionFailure("error when loading or writing to realm: \(error)")
            }
            return Disposables.create()
        }
    }
    
    private func createFirebaseAuth(email: String, password: String) -> Single<Void> {
        
        return Single.create(subscribe: { (observer) -> Disposable in
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in

                if let error = error {
                    
                    let message: String = {
                        if error.localizedDescription == "The email address is badly formatted." {
                            return "メールアドレスが不正です"
                        } else if error.localizedDescription == "The password must be 6 charactors long or more." {
                            return "パスワードの安全性が低いです"
                        } else {
                            return "メールアドレスが不正であるか、パスワードの安全性が低いです"
                        }
                    }()
                    
                    if let currentController = UIApplication.shared.keyWindow?.rootViewController {
                        let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        currentController.present(alertController, animated: true, completion: nil)
                    }
                    observer(.error(error))
                    return
                }
                
                guard let _ = authResult?.user else {
                    assertionFailure("no user")
                    return
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    private func signInFirebaseAuth(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
}
