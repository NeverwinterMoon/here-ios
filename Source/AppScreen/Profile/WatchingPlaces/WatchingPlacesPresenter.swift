//
//  WatchingPlacesPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation

final class WatchingPlacesPresenter: WatchingPlacesPresenterInterface {
    
    init(view: WatchingPlacesViewInterface, interactor: WatchingPlacesInteractorInterface, wireframe: WatchingPlacesWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: WatchingPlacesViewInterface
    private let interactor: WatchingPlacesInteractorInterface
    private let wireframe: WatchingPlacesWireframeInterface
}
