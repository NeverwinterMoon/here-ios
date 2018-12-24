//
//  DetailProfileInfoInterface.swift
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

protocol DetailProfileInfoViewInterface: ViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
    var tapEditProfileRow: Signal<IndexPath> { get }
    func update()
}

protocol DetailProfileInfoInteractorInterface: class {
    func user(userId: String)
    func activatedUser() -> Single<User>
    func getProfileImage() -> Single<UIImage>
}

extension ProfileInteractor: DetailProfileInfoInteractorInterface {}

protocol DetailProfileInfoPresenterInterface {
    var userProfileImage: Driver<UIImage> { get }
    var sections: Driver<[EditProfileInfoSection]> { get }
}

protocol DetailProfileInfoWireframeInterface {
    func showChangeProfileImageActionSheet()
    func pushEditProfileInfo(infoType: userInfoType, currentContent: String)
}
