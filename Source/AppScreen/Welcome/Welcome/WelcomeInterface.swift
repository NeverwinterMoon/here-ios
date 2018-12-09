//
//  WelcomeInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol WelcomeViewInterface {
    var tapCreateNewAccount: Signal<Void> { get }
    var tapLogin: Signal<LoginInfo> { get }
}

protocol WelcomeInteractorInterface: class {
    func login(usernameOrEmail: String, password: String)
}

extension WelcomeInteractor: WelcomeInteractorInterface {}

protocol WelcomePresenterInterface {
}

protocol WelcomeWireframeInterface {
    func pushCreateNewAccount()
    func pushLogin()
    func popLoginFailedAlert()
}
