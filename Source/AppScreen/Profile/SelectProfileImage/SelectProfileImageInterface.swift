//
//  SelectProfileImageInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

protocol SelectProfileImageViewInterface: class {
    var tapCameraRoll: Signal<Void> { get }
    var tapCamera: Signal<Void> { get }
}

protocol SelectProfileImageInteractorInterface: class {
    func updateProfile(params: [String: Any]) -> Single<Void>
}

extension ProfileInteractor: SelectProfileImageInteractorInterface {}

protocol SelectProfileImagePresenterInterface: class {
    var selectedImageRelay: BehaviorRelay<UIImage?> { get }
}

protocol SelectProfileImageWireframeInterface {
    func presentPicker(_ picker: UIImagePickerController)
    func dismissPicker()
    func showSelectedImage(_ image: UIImage)
}
