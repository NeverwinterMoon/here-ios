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
import RxSwift

final class MapPresenter: MapPresenterInterface {
    
    let nearbyFriends: BehaviorRelay<[User]> = .init(value: [])

    init(view: MapViewInterface, interactor: MapInteractorInterface, wireframe: MapWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor.nearbyFriends()
            .asObservable()
            .bind(to: self.nearbyFriends)
            .disposed(by: self.disposeBag)
        
        self.view.location
            .asObservable()
            .subscribe(onNext: {
                LocationManager.shared.sendLocation(location: $0)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: MapViewInterface
    private let interactor: MapInteractorInterface
    private let wireframe: MapWireframeInterface
    private let disposeBag = DisposeBag()
}
