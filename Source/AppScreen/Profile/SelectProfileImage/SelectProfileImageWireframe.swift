//
//  SelectProfileImageWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class SelectProfileImageWireframe: AppWireframe, SelectProfileImageWireframeInterface {
    
    func loadCamera() {

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        } else {
            
            let alert = UIAlertController(
                title: "プロフィール画像を撮影するには[設定]から、このアプリからの[カメラ]アプリへのアクセスを許可してください",
                message: nil,
                preferredStyle: .alert
            )
            self.show(alert, with: .present, animated: true)
        }
    }
    
    func selectProfileImageFromCameraRoll() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            let controller = CameraRollViewController()
            let wireframe = CameraRollWireframe(navigationController: self.navigationController)
            let presenter = CameraRollPresenter(view: controller, wireframe: wireframe)
            controller.presenter = presenter
            self.show(controller, with: .present, animated: true)
        } else {
            
            let alert = UIAlertController(
                title: "プロフィール画像をカメラロールから選択するには[設定]から、このアプリからの[写真]アプリへのアクセスを許可してください",
                message: nil,
                preferredStyle: .alert
            )
            self.show(alert, with: .present, animated: true)
        }
    }
}
