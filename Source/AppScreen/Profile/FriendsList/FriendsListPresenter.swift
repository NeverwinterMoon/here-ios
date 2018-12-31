//
//  FriendsListPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

final class FriendsListPresenter: FriendsListPresenterInterface {
    
    var sections: Driver<[FriendsListSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[FriendsListSection]> = .init(value: [])

    init(view: FriendsListViewInterface, interactor: FriendsListInteractorInterface, wireframe: FriendsListWireframe) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor.friends()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: FriendsListViewInterface
    private let interactor: FriendsListInteractorInterface
    private let wireframe: FriendsListWireframe
    private let disposeBag = DisposeBag()
}

extension Observable where E == [User] {
    
    fileprivate func mapSections() -> Observable<[FriendsListSection]> {
        
        return self.map { users in
            
            // TODO: when empty, change the view (show the message indicating that the user has no friends yet)
//            guard users.isNotEmpty else {
//                return
//            }
            
            let items = users.map { user -> FriendsListItem in
                
                return FriendsListItem(iconFilePath: user.profileImageURL, userDisplayName: user.userDisplayName, username: user.username)
            }
            
            return [FriendsListSection(items: items)]
        }
    }
}
