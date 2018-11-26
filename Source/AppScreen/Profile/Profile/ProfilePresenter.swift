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

final class ProfilePresener: ProfilePresenterInterface, Disposer {

    let profileImageURL: Driver<URL>
    let profileIntro: Driver<String>
    let friendsCount: Driver<Int>
    
    init(userId: String, view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<User> = self.interactor.user(userId: userId).asDriver(onErrorJustReturn: .init())
        
        self.profileImageURL = user.map { URL(string: $0.profileImageURL) }.filterNil()
        self.profileIntro = user.map { $0.profileIntro }
        self.friendsCount = user.map { $0.friendsCount }
        
        view.tapEditProfile
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.wireframe.presentUserInfo(userId: userId)
            })
            .dispose(with: self)

        view.tapFriends
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.wireframe.pushfFriendsList(userId: userId)
            })
            .dispose(with: self)
    }

    // MARK: - Private
    private let view: ProfileViewInterface
    private let interactor: ProfileInteractorInterface
    private let wireframe: ProfileWireframeInterface
}
