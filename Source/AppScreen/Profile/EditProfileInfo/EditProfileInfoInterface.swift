//
//  EditProfileInfoInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol EditProfileInfoViewInterface: ViewInterface {
    var tapSaveProfileInfo: Signal<String> { get }
}

protocol EditProfileInfoInteractorInterface {
    func updateProfile(params: [String: Any]) -> Single<Void>
}
extension ProfileInteractor: EditProfileInfoInteractorInterface {}

protocol EditProfileInfoPresenterInterface {
    var infoToChange: Driver<String> { get }
    var currentInfo: Driver<String> { get }
}

protocol EditProfileInfoWireframeInterface {
    func popBackToDetailProfileInfo() 
}
