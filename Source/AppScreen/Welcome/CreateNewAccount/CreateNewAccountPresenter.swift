//
//  CreateNewAccountPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxSwift

final class CreateNewAccountPresenter: CreateNewAccountPresenterInterface {
    
    init(view: CreateNewAccountViewInterface, interactor: CreateNewAccountInteractorInterface, wireframe: CreateNewAccountWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.view.tapCreateAccount
            .asObservable()
            .flatMap { [unowned self] createUserInfo in
                self.interactor.sendEmail(email: createUserInfo.email, password: createUserInfo.password)
            }
            .subscribe(onNext: { [unowned self] _ in
                self.wireframe.pushAppTabBarController()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: CreateNewAccountViewInterface
    private let interactor: CreateNewAccountInteractorInterface
    private let wireframe: CreateNewAccountWireframeInterface
    private let disposeBag = DisposeBag()
}

struct CreateUserInfo {
    let email: String
    let username: String
    let password: String
}
