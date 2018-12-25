//
//  SelectProfileImageViewModel.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppInteractor
import AppUIKit
import RxCocoa
import RxMediaPicker
import RxSwift
import RxOptional

final class SelectProfileImagePresenter: SelectProfileImagePresenterInterface, RxMediaPickerDelegate {
    
    // RxMediaPickerDelegate
    func present(picker: UIImagePickerController) {
        self.wireframe.presentPicker(picker)
    }
    
    func dismiss(picker: UIImagePickerController) {
        self.wireframe.dismissPicker()
    }

    let selectedImageRelay = BehaviorRelay<UIImage?>.init(value: nil)
    
    init(view: SelectProfileImageViewInterface, interactor: SelectProfileImageInteractorInterface, wireframe: SelectProfileImageWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.picker = RxMediaPicker(delegate: self)
        
        self.view.tapCameraRoll
            .emit(onNext: { [unowned self] in
                self.pickImage()
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapCamera
            .emit(onNext: {
                self.takePhoto()
            })
            .disposed(by: self.disposeBag)

        self.selectedImageRelay
            .filterNil()
            .subscribe(onNext: { [unowned self] in
                self.wireframe.showSelectedImage($0)
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - Private
    private let view: SelectProfileImageViewInterface
    private let interactor: SelectProfileImageInteractorInterface
    private let wireframe: SelectProfileImageWireframeInterface
    private let disposeBag = DisposeBag()
    private var picker: RxMediaPicker!
    
    private func pickImage() {
        self.picker.selectImage(source: .photoLibrary)
            .map { $0.0 }
            .bind(to: self.selectedImageRelay)
            .disposed(by: self.disposeBag)
    }
    
    private func takePhoto() {
        self.picker.selectImage(source: .camera)
            .map { $0.0 }
            .bind(to: self.selectedImageRelay)
            .disposed(by: self.disposeBag)
    }
}
