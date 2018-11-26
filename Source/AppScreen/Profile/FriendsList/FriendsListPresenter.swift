//
//  FriendsListPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class FriendsListPresenter: FriendsListPresenterInterface {
    
    var sections: Driver<[FriendsListSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[FriendsListSection]> = .init(value: [])

    init(userId: String, view: FriendsListViewInterface, interactor: FriendsListInteractorInterface, wireframe: FriendsListWireframe) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: FriendsListViewInterface
    private let interactor: FriendsListInteractorInterface
    private let wireframe: FriendsListWireframe
}
