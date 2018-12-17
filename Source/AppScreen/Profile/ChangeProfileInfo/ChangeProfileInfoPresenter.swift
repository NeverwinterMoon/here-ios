//
//  ChangeProfileInfoPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class ChangeProfileInfoPresenter: ChangeProfileInfoPresenterInterface {
    
    init(view: ChangeProfileInfoViewInterface, interactor: ChangeProfileInfoInteractorInterface, wireframe: ChangeProfileInfoWireframeInterface, infoInChange: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: ChangeProfileInfoViewInterface
    private let interactor: ChangeProfileInfoInteractorInterface
    private let wireframe: ChangeProfileInfoWireframeInterface
}
