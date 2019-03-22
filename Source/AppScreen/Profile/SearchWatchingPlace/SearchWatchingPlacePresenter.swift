//
//  SearchWatchingPlacePresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/22.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchWatchingPlacePresenter: SearchWatchingPlacePresenterInterface {
    
    init(view: SearchWatchingPlaceViewInterface, interactor: SearchWatchingPlaceInteractorInterface, wireframe: SearchWatchingPlaceWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: SearchWatchingPlaceViewInterface
    private let interactor: SearchWatchingPlaceInteractorInterface
    private let wireframe: SearchWatchingPlaceWireframeInterface
}
