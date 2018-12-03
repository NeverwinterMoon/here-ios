//
//  ChatInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

protocol ChatViewInterface: class {
}

protocol ChatInteractorInterface: class {
}

extension ChatInteractor: ChatInteractorInterface {}

protocol ChatPresenterInterface: class {
}

protocol ChatWireframeInterface: class {
    func pushChatRoom()
}
