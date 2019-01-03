//
//  SearchFriendsPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

final class SearchFriendsPresenter: SearchFriendsPresenterInterface {
    
    var section: Driver<[SearchFriendsSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[SearchFriendsSection]> = .init(value: [])
    
    init(view: SearchFriendsViewInterface, interactor: SearchFriendsInteractorInterface, wireframe: SearchFriendsWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor.allUsers()
    }
    
    // MARK: - Private
    private let view: SearchFriendsViewInterface
    private let interactor: SearchFriendsInteractorInterface
    private let wireframe: SearchFriendsWireframeInterface
}
