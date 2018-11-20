//
//  InfoInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol InfoViewInterface {
    var tapChangeProfileImage: Signal<Void> { get }
}

//protocol InfoInteractorInterface {
//    <#requirements#>
//}

protocol InfoPresenterInterface {
    var name: Driver<String> { get }
    var userId: Driver<String> { get }
    var userIntro: Driver<String> { get }
    var userEMailAddress: Driver<String> { get }
}

protocol InfoWireframeInterface {
    func showCamera()
    func showCameraRoll()
}
