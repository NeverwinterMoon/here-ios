//
//  CreateNewAccountInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol CreateNewAccountViewInterface {
    var tapCreateAccount: Signal<CreateUserInfo> { get }
}

protocol CreateNewAccountInteractorInterface {
    func sendEmail(email: String, username: String, password: String) -> Single<Void>
}

extension WelcomeInteractor: CreateNewAccountInteractorInterface {}

protocol CreateNewAccountPresenterInterface {
}

protocol CreateNewAccountWireframeInterface {
    func pushAppTabBarController()
    func showCreateNewAccountAgain()
}
