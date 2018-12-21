//
//  SelectProfileImageViewModel.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class SelectProfileImagePresenter: SelectProfileImagePresenterInterface {

    init(view: SelectProfileImageViewInterface, wireframe: SelectProfileImageWireframeInterface) {
        
        self.view = view
        self.wireframe = wireframe
    }
    
    func loadCamera() {
        self.wireframe.loadCamera()
    }
    
    func selectProfileImageFromCameraRoll() {
        self.wireframe.selectProfileImageFromCameraRoll()
    }
    
    // MARK: - Private
    private let view: SelectProfileImageViewInterface
    private let wireframe: SelectProfileImageWireframeInterface
}
