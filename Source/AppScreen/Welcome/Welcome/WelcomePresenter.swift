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

final class WelcomePresenter {
    
    init(view: WelcomeViewInterface, wireframe: WelcomeWireframeInterface) {
        
        self.view = view
        self.wireframe = wireframe
        
        self.view.tapLogIn
            .emit(onNext: {
                self.wireframe.pushLogIn()
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
