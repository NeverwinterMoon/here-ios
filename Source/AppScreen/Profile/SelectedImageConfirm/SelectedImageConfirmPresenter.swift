//
//  SelectedImageConfirmPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class SelectedImageConfirmPresenter: SelectedImageConfirmPresenterInterface {
    
    var selectedImage: Driver<UIImage>

    init(view: SelectedImageConfirmViewInterface, interactor: SelectedImageConfirmInteractorInterface, wireframe: SelectedImageConfirmWireframeInterface, selectedImage: UIImage) {
        
        self.selectedImage = Driver.just(selectedImage)
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: SelectedImageConfirmViewInterface
    private let interactor: SelectedImageConfirmInteractorInterface
    private let wireframe: SelectedImageConfirmWireframeInterface
}
