//
//  SelectedImageConfirmInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol SelectedImageConfirmViewInterface {
}

protocol SelectedImageConfirmPresenterInterface {
    var selectedImage: Driver<UIImage> { get }
}

protocol SelectedImageConfirmInteractorInterface {
}

extension ProfileInteractor: SelectedImageConfirmInteractorInterface {}

protocol SelectedImageConfirmWireframeInterface {
}
