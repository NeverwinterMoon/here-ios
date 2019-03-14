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
import CoreLocation
import RxCocoa
import RxSwift

final class MapPresenter: MapPresenterInterface {
    
    var nearbyFriendsSections: Driver<[MapSection]> {
        return self.nearbyFriendsSectionsRelay.asDriver()
    }
    private let nearbyFriendsSectionsRelay: BehaviorRelay<[MapSection]> = .init(value: [])
    
    var nearSpotFriendsSections: Driver<[MapSection]> {
        return self.nearSpotFriendsSectionsRelay.asDriver()
    }
    private let nearSpotFriendsSectionsRelay: BehaviorRelay<[MapSection]> = .init(value: [])

    init(view: MapViewInterface, interactor: MapInteractorInterface, wireframe: MapWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.view
            .viewWillAppear
            .flatMap { [unowned self] in
                self.interactor.getNearbyFriends()
                    .asObservable()
                    .mapSections()
            }
            .bind(to: self.nearbyFriendsSectionsRelay)
            .disposed(by: self.disposeBag)
        
        self.view
            .viewWillAppear
            .flatMap { [unowned self] in
                self.interactor.getNearSpotFriends()
                    .asObservable()
                    .mapSections()
            }
            .bind(to: self.nearSpotFriendsSectionsRelay)
            .disposed(by: self.disposeBag)

        self.view.location
            .asObservable()
            .flatMap { [unowned self] in
                self.interactor.updateLocation(location: $0)
            }
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: MapViewInterface
    private let interactor: MapInteractorInterface
    private let wireframe: MapWireframeInterface
    private let disposeBag = DisposeBag()
}

extension Observable where E == [User] {
    
    fileprivate func mapSections() -> Observable<[MapSection]> {
        
        return self.map { users in
            let items = users.map { user -> MapItem in
                MapItem(userId: user.id, profileImageURL: user.profileImageURL, userDisplayName: user.userDisplayName, username: user.username)
            }
            return [MapSection(items: items)]
        }
    }
}
