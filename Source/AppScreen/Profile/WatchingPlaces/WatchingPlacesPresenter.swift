//
//  WatchingPlacesPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

final class WatchingPlacesPresenter: WatchingPlacesPresenterInterface {
    
    var sections: Driver<[WatchingPlacesSection]> {
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[WatchingPlacesSection]> = .init(value: [])
    
    init(view: WatchingPlacesViewInterface, interactor: WatchingPlacesInteractorInterface, wireframe: WatchingPlacesWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor.getWatchingPlaces()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
        
        self.view.tapAddWatchingPlace
            .emit(onNext: { [unowned self] in
                self.wireframe.pushCreateWatchingPlace()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: WatchingPlacesViewInterface
    private let interactor: WatchingPlacesInteractorInterface
    private let wireframe: WatchingPlacesWireframeInterface
    private let disposeBag = DisposeBag()
}

extension Observable where E == [WatchingPlace] {
    
    fileprivate func mapSections() -> Observable<[WatchingPlacesSection]> {
        
        return self.map { places -> [WatchingPlacesSection] in
            
            let items = places.map { place -> WatchingPlacesItem in
                WatchingPlacesItem(name: place.name)
            }
            
            return [WatchingPlacesSection(items: items)]
        }
    }
}
