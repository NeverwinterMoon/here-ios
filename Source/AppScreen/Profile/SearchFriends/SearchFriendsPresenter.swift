//
//  SearchFriendsPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import PKHUD
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
        
        self.view.searchText
            .debounce(0.5)
            .filterNil()
            .distinctUntilChanged()
            .filterEmpty()
            .asObservable()
            .do(onNext: { _ in
                HUD.show(.labeledProgress(title: "検索中...", subtitle: nil))
            })
            .flatMap { text -> Observable<[SearchFriendsSection]> in
                self.interactor.usersWithPrefix(of: text).asObservable().mapSections()
            }
            .do(onNext: { _ in
                HUD.hide()
            })
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
        
        self.view.tapFriendProfile
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item].userId
            }
            .asObservable()
            .concatMap { selectedUserId -> Single<(String, String)> in
                self.interactor.activatedUser().map { (selectedUserId, $0.id) }
            }
            .subscribe(onNext: {
                if $0 == $1 {
                    self.wireframe.pushProfile()
                } else {
                    self.wireframe.pushFriendProfile(userId: $0)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: SearchFriendsViewInterface
    private let interactor: SearchFriendsInteractorInterface
    private let wireframe: SearchFriendsWireframeInterface
    private let disposeBag = DisposeBag()
}

extension Observable where E == [User] {
    
    fileprivate func mapSections() -> Observable<[SearchFriendsSection]> {
        
        return self.map { users -> [SearchFriendsSection] in

                let items = users.map { user -> SearchFriendsItem in
                    SearchFriendsItem(userId: user.id, displayName: user.userDisplayName, username: user.username, profileImageURL: user.profileImageURL)
                }
                return [SearchFriendsSection(items: items)]
            }
    }
}
