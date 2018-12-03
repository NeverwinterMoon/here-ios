//
//  ChatPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class ChatPresenter: ChatPresenterInterface {
    
    init(view: ChatViewInterface, interactor: ChatInteractorInterface, wireframe: ChatWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    let view: ChatViewInterface
    let interactor: ChatInteractorInterface
    let wireframe: ChatWireframeInterface
}
