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
import RxCocoa
import RxSwift

protocol WatchingPlacesViewInterface {
    var tapAddWatchingPlace: Signal<Void> { get }
}

protocol WatchingPlacesInteractorInterface {
    func getWatchingPlaces() -> Single<[WatchingPlace]>
}

extension ProfileInteractor: WatchingPlacesInteractorInterface {}

protocol WatchingPlacesPresenterInterface {
    var sections: Driver<[WatchingPlacesSection]> { get }
}

protocol WatchingPlacesWireframeInterface {
    func pushCreateWatchingPlace()
}
