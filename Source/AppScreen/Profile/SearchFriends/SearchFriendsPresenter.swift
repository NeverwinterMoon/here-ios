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
        
        let allUsers = self.interactor.allUsers().asObservable()
        
        self.view.searchText
            .debounce(0.5)
            .distinctUntilChanged()
            .filterEmpty()
            .asObservable()
            .flatMap { text -> Observable<[SearchFriendsSection]> in
                allUsers.mapSections(query: text)
            }
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: SearchFriendsViewInterface
    private let interactor: SearchFriendsInteractorInterface
    private let wireframe: SearchFriendsWireframeInterface
    private let disposeBag = DisposeBag()
}

extension Observable where E == [User] {
    
    fileprivate func mapSections(query: String) -> Observable<[SearchFriendsSection]> {
        
        return self.map {
                $0.filter { $0.userDisplayName.hasPrefix(query) || $0.username.hasPrefix(query) }
            }
            .map { users -> [SearchFriendsSection] in
                
                let items = users.map { user in
                    SearchFriendsItem(icon: user.profileImageURL, displayName: user.userDisplayName)
                }
                return [SearchFriendsSection(items: items)]
            }
    }
}
