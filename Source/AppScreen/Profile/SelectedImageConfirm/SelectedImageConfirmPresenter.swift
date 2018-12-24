//
//  SelectedImageConfirmPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SelectedImageConfirmPresenter: SelectedImageConfirmPresenterInterface {
    
    var selectedImage: Driver<UIImage>

    init(view: SelectedImageConfirmViewInterface, interactor: SelectedImageConfirmInteractorInterface, wireframe: SelectedImageConfirmWireframeInterface, selectedImage: UIImage) {
        
        self.selectedImage = Driver.just(selectedImage)
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.view.tapSelect
            .asObservable()
            .flatMap { [unowned self] _ -> Single<Void> in
                let filePath = UUID().uuidString.lowercased()
                let params = ["profile_image_url": filePath]
                self.interactor.updateProfileImage(image: selectedImage, filePath: filePath)
                return self.interactor.updateProfile(params: params)
            }
            .subscribe(onNext: { [unowned self] in
                self.wireframe.popBack()
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapCancel
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                self.wireframe.popBack()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: SelectedImageConfirmViewInterface
    private let interactor: SelectedImageConfirmInteractorInterface
    private let wireframe: SelectedImageConfirmWireframeInterface
    private let disposeBag = DisposeBag()
}
