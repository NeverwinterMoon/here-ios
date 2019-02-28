//
//  ChatRoomInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol ChatRoomViewInterface: class {
}

protocol ChatRoomInteractorInterface: class {
    func getUser(userId: String) -> Single<User>
}

extension ChatInteractor: ChatRoomInteractorInterface {}

protocol ChatRoomPresenterInterface: class {
    var userDisplayName: Driver<String> { get }
    var userId: Driver<String> { get }
}

protocol ChatRoomWireframeInterface: class {
}
