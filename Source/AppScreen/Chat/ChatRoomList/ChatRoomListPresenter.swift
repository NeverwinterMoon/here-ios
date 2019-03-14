//
//  ChatRoomListPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

final class ChatRoomListPresenter: ChatRoomListPresenterInterface {
    
    init(view: ChatRoomListViewInterface, interactor: ChatRoomListInteractorInterface, wireframe: ChatRoomListWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: ChatRoomListViewInterface
    private let interactor: ChatRoomListInteractorInterface
    private let wireframe: ChatRoomListWireframeInterface
    private let disposeBag = DisposeBag()
}
