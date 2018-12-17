//
//  ChangeProfileInfoPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class ChangeProfileInfoPresenter: ChangeProfileInfoPresenterInterface {
    
    let infoInChange: Driver<String>
    let currentContent: Driver<String>

    init(view: ChangeProfileInfoViewInterface, interactor: ChangeProfileInfoInteractorInterface, wireframe: ChangeProfileInfoWireframeInterface, infoInChangeInString: String, currentContent: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.infoInChange = Driver<String>.just(infoInChangeInString)
        self.currentContent = Driver<String>.just(currentContent)
    }
    
    // MARK: - Private
    private let view: ChangeProfileInfoViewInterface
    private let interactor: ChangeProfileInfoInteractorInterface
    private let wireframe: ChangeProfileInfoWireframeInterface
}
