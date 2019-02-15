//
//  RequestedUserPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation

final class RequestedUserPresenter: RequestedUserPresenterInterface {
    
    init(view: RequestedUserViewInterface, interactor: RequestedUserInteractorInterface, wireframe: RequestedUserWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: RequestedUserViewInterface
    private let interactor: RequestedUserInteractorInterface
    private let wireframe: RequestedUserWireframeInterface
}
