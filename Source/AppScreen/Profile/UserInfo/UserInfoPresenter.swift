//
//  UserInfoPresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class UserInfoPresenter: UserInfoPresenterInterface {
    
    let name: Driver<String>
    let userId: Driver<String>
    let userIntro: Driver<String>
    let userEMailAddress: Driver<String>
    
    init(userId: String, view: UserInfoViewInterface, interactor: UserInfoInteractorInterface, wireframe: UserInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
    }
    
    // MARK: - Private
    private let view: UserInfoViewInterface
    private let interactor: UserInfoInteractorInterface
    private let wireframe: UserInfoWireframeInterface
}
