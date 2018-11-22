//
//  UserInfoInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol UserInfoViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
}

protocol UserInfoInteractorInterface {
    <#requirements#>
}

protocol UserInfoPresenterInterface {
    var userEmailAddress: Driver<String> { get }
    var userIntro: Driver<String> { get }
    var userProfileImageURL: Driver<URL> { get }
}

protocol UserInfoWireframeInterface {
    func showCamera()
    func showCameraRoll()
}
