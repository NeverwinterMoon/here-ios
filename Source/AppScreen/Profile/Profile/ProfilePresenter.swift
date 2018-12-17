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

    let username: Driver<String>
    let userDisplayName: Driver<String>
    let profileImageURL: Driver<URL>
    let selfIntroduction: Driver<String?>

    init(view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init()).filterNil()

        self.username = user.map { $0.username }
        self.userDisplayName = user.map { $0.userDisplayName }
//        self.profileImageURL = account.map { URL(string: $0.profileImageURL) }.filterNil()
        self.profileImageURL = Driver.just(URL(string: "test")).filterNil()
        self.selfIntroduction = user.map { $0.selfIntroduction }

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
