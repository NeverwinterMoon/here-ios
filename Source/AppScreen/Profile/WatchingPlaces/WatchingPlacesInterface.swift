//
//  WatchingPlacesInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxSwift

protocol WatchingPlacesViewInterface {
}

protocol WatchingPlacesInteractorInterface {
    func getWatchingPlaces() -> Single<[WatchingPlace]>
}

extension ProfileInteractor: WatchingPlacesInteractorInterface {}

protocol WatchingPlacesPresenterInterface {
}

protocol WatchingPlacesWireframeInterface {
}
