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
    var profileImageURL: Driver<URL?>
    var selfIntroduction: Driver<String?>

    init(view: ProfileViewInterface, interactor: ProfileInteractorInterface, wireframe: ProfileWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        // TODO: clean up these shit code
        let user = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init())

        self.username = user.map { $0.username }
        self.userDisplayName = user.map { $0.userDisplayName }
//        self.profileImageURL = account.map { URL(string: $0.profileImageURL) }.filterNil()
        self.profileImageURL = Driver.just(URL(string: "test"))
        self.selfIntroduction = user.map { $0.selfIntroduction }
        
        self.view.viewWillAppear
            .flatMap { [unowned self] in
                self.interactor.activatedUser()
            }
            .map { [unowned self] in
                self.username = Driver.just($0.username)
                self.userDisplayName = Driver.just($0.userDisplayName)
                self.profileImageURL = Driver.just(URL(string: $0.profileImageURL ?? ""))
                self.selfIntroduction = Driver.just($0.selfIntroduction)
            }
            .subscribe()
            .disposed(by: self.disposeBag)

        self.view.tapEditProfile
            .emit(onNext: { [unowned self] in
                self.wireframe.presentUserInfo()
            })
            .disposed(by: self.disposeBag)

        self.view.tapFriends
            .emit(onNext: { [unowned self] in
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
