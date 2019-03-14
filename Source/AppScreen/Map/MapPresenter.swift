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
    
    var sections: Driver<[MapSection]> {
        return self.sectionsRelay.asDriver()
    }
    private let sectionsRelay: BehaviorRelay<[MapSection]> = .init(value: [])

    init(view: MapViewInterface, interactor: MapInteractorInterface, wireframe: MapWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor
            .getNearbyFriends()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)

        self.view.location
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                self.interactor.updateLocation(location: $0)
            })
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
