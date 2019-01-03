//
//  ProfilePresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppExtensions
import AppInteractor
import RxCocoa
import RxSwift
import RxOptional

final class ProfilePresenter: ProfilePresenterInterface {

    var username: Driver<String>
    var userDisplayName: Driver<String>
    var selfIntroduction: Driver<String?>
    var profileImage: Driver<UIImage>
    let user: Driver<User>
    
    var sections: Driver<[ProfileSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[ProfileSection]> = .init(value: [])
    
    init(view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.user = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init())
        self.username = self.user.map { $0.username }
        self.userDisplayName = self.user.map { $0.userDisplayName }
        self.selfIntroduction = self.user.map { $0.selfIntroduction }
        
        self.profileImage = self.interactor.getSelfProfileImage().asDriver(onErrorJustReturn: UIImage())
        
        let items = [
            ProfileItem(icon: UIImage(named: "first"), title: "友達", type: .friends),
            ProfileItem(icon: UIImage(named: "first"), title: "友達を検索する", type: .searchFriends)
        ]
        Observable.just(items).map { item -> [ProfileSection] in
            [ProfileSection(items: items)]
        }
        .bind(to: self.sectionsRelay)
        .disposed(by: self.disposeBag)

        self.view.viewWillAppear
            .do(onNext: { [unowned self] in
                self.view.update()
            })
            .flatMap { [unowned self] in
                self.interactor.activatedUser()
            }
            .subscribe(onNext: {
                self.interactor.user(userId: $0.id)
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapEditProfile
            .emit(onNext: { [unowned self] in
                self.wireframe.presentUserInfo()
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapProfileRow
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item].type
            }
            .emit(onNext: { [unowned self] in
                switch $0 {
                case .friends:
                    self.wireframe.pushfFriendsList()
                case .searchFriends:
                    self.wireframe.pushSearchFriends()
                }
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - Private
    private let view: ProfileViewInterface
    private let interactor: ProfileInteractorInterface
    private let wireframe: ProfileWireframeInterface
    private let disposeBag = DisposeBag()
}
