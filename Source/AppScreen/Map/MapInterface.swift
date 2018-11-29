//
//  MapInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol MapViewInterface: class {
}

protocol MapInteractorInterface: class {
    func nearbyFriends(userId: String) -> Single<[User]>
}

extension MapInteractor: MapInteractorInterface {}

protocol MapPresenterInterface: class {
    var nearbyFriends: Driver<[User]> { get }
}

protocol MapWireframeInterface: class {
}
