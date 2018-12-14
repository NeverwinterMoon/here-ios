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

final class EditUserInfoPresenter: EditUserInfoPresenterInterface {
    
    let userEmailAddress: Driver<String?>
    let userProfileIntro: Driver<String?>
    let userProfileImageURL: Driver<URL>
    
    var sections: Driver<[EditProfileInfoSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[EditProfileInfoSection]> = .init(value: [])

    init(view: EditUserInfoViewInterface, interactor: EditUserInfoInteractorInterface, wireframe: EditUserInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<Me> = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init())
        
        self.userEmailAddress = user.map { $0.email }
        self.userProfileIntro = user.map { $0.selfIntroduction }
        self.userProfileImageURL = user.map { URL(string: $0.profileImageURL!) }.filterNil()
    }
    
    // MARK: - Private
    private let view: EditUserInfoViewInterface
    private let interactor: EditUserInfoInteractorInterface
    private let wireframe: EditUserInfoWireframeInterface
}
