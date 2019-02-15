//
//  ChatRoomListPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class ChatRoomListPresenter: ChatRoomListPresenterInterface {
    
    init(view: ChatRoomListViewInterface, interactor: ChatRoomListInteractorInterface, wireframe: ChatRoomListWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    let view: ChatRoomListViewInterface
    let interactor: ChatRoomListInteractorInterface
    let wireframe: ChatRoomListWireframeInterface
}
