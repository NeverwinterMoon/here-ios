//
//  EditProfileInfoPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class EditProfileInfoPresenter: EditProfileInfoPresenterInterface {
    
    let infoInChange: Driver<String>
    let currentContent: Driver<String>

    init(view: EditProfileInfoViewInterface, interactor: EditProfileInfoInteractorInterface, wireframe: EditProfileInfoWireframeInterface, infoInChangeInString: String, currentContent: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.infoInChange = Driver<String>.just(infoInChangeInString)
        self.currentContent = Driver<String>.just(currentContent)
    }
    
    // MARK: - Private
    private let view: EditProfileInfoViewInterface
    private let interactor: EditProfileInfoInteractorInterface
    private let wireframe: EditProfileInfoWireframeInterface
}
