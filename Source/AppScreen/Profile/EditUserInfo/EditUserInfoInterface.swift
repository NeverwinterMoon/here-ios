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

protocol EditUserInfoViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
}

protocol EditUserInfoInteractorInterface: class {
    func activatedUser() -> Single<User?>
}

extension ProfileInteractor: EditUserInfoInteractorInterface {}

protocol EditUserInfoPresenterInterface {
    var userEmailAddress: Driver<String?> { get }
    var userProfileIntro: Driver<String?> { get }
    var userProfileImageURL: Driver<URL> { get }
    var sections: Driver<[EditProfileInfoSection]> { get }
}

protocol EditUserInfoWireframeInterface {
    func showCamera()
    func showCameraRoll()
    func pushChangeEmailAddress()
}
