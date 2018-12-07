//
//  CreateNewAccountPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class CreateNewAccountPresenter: CreateNewAccountPresenterInterface {
    
    init(view: CreateNewAccountViewInterface, interactor: CreateNewAccountInteractorInterface, wireframe: CreateNewAccountWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: CreateNewAccountViewInterface
    private let interactor: CreateNewAccountInteractorInterface
    private let wireframe: CreateNewAccountWireframeInterface
}
