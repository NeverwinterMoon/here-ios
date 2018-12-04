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

final class ProfilePresenter: ProfilePresenterInterface {

    let profileImageURL: Driver<URL>
    let profileIntro: Driver<String>
    let friendsCount: Driver<Int>
    
    init(view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
//        let me: Driver<Me> = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init())
//
//        self.profileImageURL = me.map { URL(string: $0.profileImageURL) }.filterNil()
//        self.profileIntro = me.map { $0.profileIntro }
//        self.friendsCount = me.map { $0.friendsCount }
        self.profileImageURL = Driver.just(URL(string: "test")).filterNil()
        self.profileIntro = Driver.just("test")
        self.friendsCount = Driver.just(1)
        
        self.view.tapEditProfile
            .emit(onNext: { [unowned self] _ in
                self.wireframe.presentUserInfo()
            })
            .disposed(by: disposeBag)

        self.view.tapFriends
            .emit(onNext: { [unowned self] _ in
                self.wireframe.pushfFriendsList()
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - Private
    private let view: ProfileViewInterface
    private let interactor: ProfileInteractorInterface
    private let wireframe: ProfileWireframeInterface
    private let disposeBag = DisposeBag()
}
