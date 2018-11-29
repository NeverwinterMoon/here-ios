//
//  MapPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa

final class MapPresenter: MapPresenterInterface {
    
    let nearbyFriends: Driver<[User]>

    init(userId: String, view: MapViewInterface, interactor: MapInteractorInterface, wireframe: MapWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.nearbyFriends = interactor.nearbyFriends(userId: userId).asDriver(onErrorJustReturn: .init([]))
    }
    
    // MARK: - Private
    private let view: MapViewInterface
    private let interactor: MapInteractorInterface
    private let wireframe: MapWireframeInterface
}
