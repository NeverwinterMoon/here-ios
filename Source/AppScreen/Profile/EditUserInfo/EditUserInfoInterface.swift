//
//  EditUserInfoInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol UserInfoViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
}

protocol UserInfoInteractorInterface: class {
    func activatedUser() -> Single<Me>
}

extension ProfileInteractor: UserInfoInteractorInterface {}

protocol UserInfoPresenterInterface {
    var userEmailAddress: Driver<String> { get }
    var userProfileIntro: Driver<String> { get }
    var userProfileImageURL: Driver<URL> { get }
    var sections: Driver<[ProfileInfoSection]> { get }
}

protocol UserInfoWireframeInterface {
    func showCamera()
    func showCameraRoll()
    func pushChangeEmailAddress()
}
