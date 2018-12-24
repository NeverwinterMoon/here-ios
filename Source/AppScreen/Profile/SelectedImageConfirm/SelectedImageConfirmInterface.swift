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
    var tapSelect: Signal<Void> { get }
    var tapCancel: Signal<Void> { get }
}

protocol SelectedImageConfirmPresenterInterface {
    var selectedImage: Driver<UIImage> { get }
}

protocol SelectedImageConfirmInteractorInterface {
    func updateProfile(params: [String: Any]) -> Single<Void>
    func updateProfileImage(image: UIImage, filePath: String)
}

extension ProfileInteractor: SelectedImageConfirmInteractorInterface {}

protocol SelectedImageConfirmWireframeInterface {
    func selectImage()
    func popBack()
}
