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
        
        let actions = [
            ActionSheetItem<UIImagePickerController.SourceType>(
                title: "カメラロールから選択",
                actionType: .savedPhotosAlbum,
                style: .default
            ),
            ActionSheetItem<UIImagePickerController.SourceType>(
                title: "撮影する",
                actionType: .camera,
                style: .default
            )
        ]
        let presenter = SelectProfileImagePresenter()
        
        self.navigationController
            .showActionSheet(title: "プロフィール画像を選択", actions: actions)
            .subscribe { [unowned self] in
                if let sourceType = $0.element {
                    switch sourceType {
                    case .camera, .savedPhotosAlbum:
                        presenter.launchImagePicker(type: sourceType, navigationController: self.navigationController)
                    case .photoLibrary:
                        break
                    }
                }
            }
            .disposed(by: self.disposeBag)
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
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
