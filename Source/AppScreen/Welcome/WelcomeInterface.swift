//
//  WelcomeInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol WelcomeViewInterface {
    var tapCreateNewAccount: Signal<Void> { get }
    var tapLogIn: Signal<Void> { get }
}

protocol WelcomeWireframeInterface {
    func pushCreateNewAccount()
    func pushLogIn()
}
