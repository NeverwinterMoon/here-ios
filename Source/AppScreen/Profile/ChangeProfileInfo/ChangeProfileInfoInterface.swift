//
//  ChangeProfileInfoInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol ChangeProfileInfoViewInterface {
    var tapSaveProfileInfo: Signal<Void> { get }
}

protocol ChangeProfileInfoInteractorInterface {
    func updateProfileInfo() -> Single<Void>
}
extension ProfileInteractor: ChangeProfileInfoInteractorInterface {}

protocol ChangeProfileInfoPresenterInterface {
}

protocol ChangeProfileInfoWireframeInterface {
}
