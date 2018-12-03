//
//  RootPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppInteractor

public final class RootPresenter: Disposer {
    
    public init(wireframe: RootWireframeInterface, interactor: RootInteractorInterface) {
        
        self.wireframe = wireframe
        self.interactor = interactor
        
        interactor.state
            .take(1)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .hasAccount:
                    self.wireframe.setRootTabBar()
                case .noAccount:
//                    self.wireframe.setWelcome()
                    self.wireframe.setRootTabBar()
                }
            })
            .dispose(with: self)
    }
    
    // MARK: - Private
    private let wireframe: RootWireframeInterface
    private let interactor: RootInteractorInterface
}
