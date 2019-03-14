//
//  MapInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import CoreLocation
import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol MapViewInterface: class, ViewInterface {
    var location: Signal<CLLocationCoordinate2D> { get }
}

protocol MapInteractorInterface: class {
    func getNearbyFriends() -> Single<[User]>
    func updateLocation(location: CLLocationCoordinate2D) -> Single<Void>
}

extension MapInteractor: MapInteractorInterface {}

protocol MapPresenterInterface: class {
    var sections: Driver<[MapSection]> { get }
}

protocol MapWireframeInterface: class {
}
