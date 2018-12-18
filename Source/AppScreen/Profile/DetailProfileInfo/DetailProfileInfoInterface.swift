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

protocol DetailProfileInfoViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
    var tapEditProfileRow: Signal<IndexPath> { get }
}

protocol DetailProfileInfoInteractorInterface: class {
    func activatedUser() -> Single<User?>
}

extension ProfileInteractor: DetailProfileInfoInteractorInterface {}

protocol DetailProfileInfoPresenterInterface {
    var userEmailAddress: Driver<String?> { get }
    var selfIntroduction: Driver<String?> { get }
    var userProfileImageURL: Driver<URL> { get }
    var sections: Driver<[EditProfileInfoSection]> { get }
}

protocol DetailProfileInfoWireframeInterface {
    func showChangeProfileImageActionSheet()
    func pushEditProfileInfo(infoInChange: String, currentContent: String)
}
