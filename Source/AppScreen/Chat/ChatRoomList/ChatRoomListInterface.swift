//
//  ChatRoomListInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

protocol ChatRoomListViewInterface: class {
}

protocol ChatRoomListInteractorInterface: class {
}

extension ChatInteractor: ChatRoomListInteractorInterface {}

protocol ChatRoomListPresenterInterface: class {
}

protocol ChatRoomListWireframeInterface: class {
    func pushChatRoom()
}
