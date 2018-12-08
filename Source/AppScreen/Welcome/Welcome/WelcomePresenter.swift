//
//  WelcomePresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class WelcomePresenter: WelcomePresenterInterface {
    
    init(view: WelcomeViewInterface, wireframe: WelcomeWireframeInterface) {
        
        self.view = view
        self.wireframe = wireframe
        
        self.view.tapLogin
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapCreateNewAccount
            .emit(onNext: {
                self.wireframe.pushCreateNewAccount()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
    private let view: WelcomeViewInterface
    private let wireframe: WelcomeWireframeInterface
}

struct LoginInfo {
    let username: String
    let email: String
}
