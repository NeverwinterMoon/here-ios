//
//  EditUserInfoPresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxOptional
import RxSwift

final class UserInfoPresenter: UserInfoPresenterInterface {
    
    let userEmailAddress: Driver<String>
    let userProfileIntro: Driver<String>
    let userProfileImageURL: Driver<URL>
    
    var sections: Driver<[ProfileInfoSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[ProfileInfoSection]> = .init(value: [])

    init(view: UserInfoViewInterface, interactor: UserInfoInteractorInterface, wireframe: UserInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<Me> = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init())
        
        self.userEmailAddress = user.map { $0.emailAddress }
        self.userProfileIntro = user.map { $0.profileIntro }
        self.userProfileImageURL = user.map { URL(string: $0.profileImageURL) }.filterNil()
    }
    
    // MARK: - Private
    private let view: UserInfoViewInterface
    private let interactor: UserInfoInteractorInterface
    private let wireframe: UserInfoWireframeInterface
}
