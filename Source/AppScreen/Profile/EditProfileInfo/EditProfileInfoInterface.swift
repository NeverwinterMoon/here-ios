//
//  EditProfileInfoInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol EditProfileInfoViewInterface {
    var tapSaveProfileInfo: Signal<Void> { get }
}

protocol EditProfileInfoInteractorInterface {
    func updateProfileInfo() -> Single<Void>
}
extension ProfileInteractor: EditProfileInfoInteractorInterface {}

protocol EditProfileInfoPresenterInterface {
    var infoInChange: Driver<String> { get }
    var currentContent: Driver<String> { get }
}

protocol EditProfileInfoWireframeInterface {
}
