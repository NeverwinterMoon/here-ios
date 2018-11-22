//
//  ProfilePresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppFoundation
import AppInteractor
import CustomExtensions
import RxCocoa
import RxSwift

final class ProfilePresener: ProfilePresenterInterface {
    
    let profileImageURL: Driver<URL>
    let profileInfo: Driver<String>
    let friendsNumber: Driver<Int>
    
    init(userId: String, view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<User> = self.interactor.user(userId: userId).asDriver(onErrorJustReturn: .init())
        
        self.profileImageURL = user.map { $0.profileImageURL }
        self.profileInfo = uesr.map { $0.profileInfo }
        
        view.tapEditProfile
            .subscribe(onNext: { [unowned self] _ in
                self.wireframe.presentUserInfo(userId: userId)
            })
            .dispose(with: self)
        
        view.tapFriends
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
