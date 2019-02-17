//
//  ChatRoomListWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class ChatRoomListWireframe: AppWireframe, ChatRoomListWireframeInterface {

    func pushChatRoom(userId: String) {
        let wireframe = ChatRoomWireframe(navigationController: self.navigationController)
        let controller = ChatRoomViewController()
        let presenter = ChatRoomPresenter(view: controller, interactor: ChatInteractor.shared, wireframe: wireframe, with: userId)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
