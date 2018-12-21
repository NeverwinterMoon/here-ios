//
//  DetailProfileInfoWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import AppUIKit
import RxCocoa
import RxSwift

final class DetailProfileInfoWireframe: AppWireframe, DetailProfileInfoWireframeInterface {
    
    func showChangeProfileImageActionSheet() {
        
        let actionSheet = UIAlertController(title: "プロフィール画像を選択", message: nil, preferredStyle: .actionSheet)
//        let cameraAction = UIAlertAction(title: "カメラロールから選択", style: .default, handler: nil)
        let cameraAction = UIAlertAction(title: "カメラロールから選択", style: .default) { (action) in
            let viewModel = CameraRollViewModel()
            let controller = CameraRollViewController()
            controller.viewModel = viewModel
            self.show(controller, with: .push, animated: true)
        }
        let takePhotoAction = UIAlertAction(title: "写真を撮る", style: .default, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.show(actionSheet, with: .present, animated: true)
    }
    
    func pushEditProfileInfo(infoType: userInfoType, currentContent: String) {
        
        let controller = EditProfileInfoViewController()
        let wireframe = EditProfileInfoWireframe(navigationController: self.navigationController)
        let presenter = EditProfileInfoPresenter(
            view: controller,
            interactor: ProfileInteractor.shared,
            wireframe: wireframe,
            infoType: infoType,
            currentContent: currentContent
        )
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
