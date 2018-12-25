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

        let wireframe = SelectProfileImageWireframe(navigationController: self.navigationController)
        let controller = SelectProfileImageViewController(title: "プロフィール画像を選択", message: nil, preferredStyle: .actionSheet)
        let presenter = SelectProfileImagePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .present, animated: true)
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
