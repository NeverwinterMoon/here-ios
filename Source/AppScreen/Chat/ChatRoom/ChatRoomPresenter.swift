//
//  ChatRoomPresenter.swift
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

final class ChatRoomPresenter: ChatRoomPresenterInterface {
    
    var userDisplayName: Driver<String>
    var userId: Driver<String>
    
    init(view: ChatRoomViewInterface, interactor: ChatRoomInteractorInterface, wireframe: ChatRoomWireframeInterface, with userId: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user = self.interactor.getUser(userId: userId)
        
        self.userDisplayName = user.map { $0.userDisplayName }.asDriver(onErrorJustReturn: "")
        self.userId = user.map { $0.id }.asDriver(onErrorJustReturn: "")
    }
    
    // MARK: - Private
    private let view: ChatRoomViewInterface
    private let interactor: ChatRoomInteractorInterface
    private let wireframe: ChatRoomWireframeInterface
}
