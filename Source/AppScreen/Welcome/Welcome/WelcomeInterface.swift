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
    var tapLogIn: Signal<Void> { get }
}

protocol WelcomeInteractorInterface: class {
    func validlogIn(userId: String, passWord: String) -> Single<Bool>
}

extension WelcomeInteractor: WelcomeInteractorInterface {}

protocol WelcomePresenterInterface {
}

protocol WelcomeWireframeInterface {
    func pushCreateNewAccount()
    func pushLogIn()
}
