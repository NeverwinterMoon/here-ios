//
//  WelcomePresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

final class WelcomePresenter: WelcomePresenterInterface {
    
    init(view: WelcomeViewInterface, interactor: WelcomeInteractorInterface, wireframe: WelcomeWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.view.tapLogin
            .asObservable()
            .flatMap { [unowned self] in
                self.interactor.login(usernameOrEmail: $0.usernameOrEmail, password: $0.password)
            }
            .subscribe(onNext: { [unowned self] _ in
                self.wireframe.pushLogin()
            }, onError: { [unowned self] _ in
                self.wireframe.showWelcomeAgain()
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapCreateNewAccount
            .emit(onNext: { [unowned self] in
                self.wireframe.pushCreateNewAccount()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
    private let view: WelcomeViewInterface
    private let interactor: WelcomeInteractorInterface
    private let wireframe: WelcomeWireframeInterface
}

struct LoginInfo {
    let usernameOrEmail: String
    let password: String
}
