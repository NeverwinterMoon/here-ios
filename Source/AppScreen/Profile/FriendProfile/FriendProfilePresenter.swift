//
//  FriendProfilePresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa

final class FriendProfilePresenter: FriendProfilePresenterInterface {
    
    init(view: FriendProfileViewInterface, interactor: FriendProfileInteractorInterface, wireframe: FriendProfileWireframeInterface, userId: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: FriendProfileViewInterface
    private let interactor: FriendProfileInteractorInterface
    private let wireframe: FriendProfileWireframeInterface
}
