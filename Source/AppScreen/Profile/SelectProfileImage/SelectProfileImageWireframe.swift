//
//  SelectProfileImageWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxMediaPicker

final class SelectProfileImageWireframe: AppWireframe, SelectProfileImageWireframeInterface {
    
    func presentPicker(_ picker: UIImagePickerController) {
        self.show(picker, with: .present, animated: true)
    }
    
    func dismissPicker() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func showSelectedImage(_ image: UIImage) {
        
        let controller = SelectedImageConfirmViewController()
        let wireframe = SelectedImageConfirmWireframe(navigationController: self.navigationController)
        let presenter = SelectedImageConfirmPresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe, selectedImage: image)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
