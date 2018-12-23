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
    
    let selectedImageRelay = BehaviorRelay<UIImage?>.init(value: nil)
    func showChangeProfileImageActionSheet() {
        
        
        let wireframe = SelectProfileImageWireframe(navigationController: self.navigationController)
        let controller = SelectProfileImageViewController(title: "プロフィール画像を選択", message: nil, preferredStyle: .actionSheet)
        let presenter = SelectProfileImagePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .present, animated: true)
//        let actions = [
//            ActionSheetItem<UIImagePickerController.SourceType>(
//                title: "カメラロールから選択",
//                actionType: .savedPhotosAlbum,
//                style: .default
//            ),
//            ActionSheetItem<UIImagePickerController.SourceType>(
//                title: "撮影する",
//                actionType: .camera,
//                style: .default
//            )
//        ]
//
//        self.navigationController
//            .showActionSheet(controller: controller, actions: actions)
//            .subscribe { [unowned self] in
//                if let sourceType = $0.element {
//                    switch sourceType {
//                    case .camera, .savedPhotosAlbum:
//                        UIImagePickerController.rx.createWithParent(self.navigationController) { picker in
//                                picker.sourceType = sourceType
//                                picker.allowsEditing = true
//                            }
//                            .flatMap {
//                                $0.rx.didFinishPickingMediaWithInfo
//                            }
//                            .debug("debug launch")
//                            .take(1)
//                            .map { $0[UIImagePickerController.InfoKey.originalImage] as? UIImage }
//                            .bind(to: self.selectedImageRelay)
//                            .disposed(by: self.disposeBag)
//                    case .photoLibrary:
//                        assertionFailure("haven't implemented this part yet")
//                        break
//                    }
//                }
//            }
//            .disposed(by: self.disposeBag)
//
//        self.selectedImageRelay
//            .filterNil()
//            .debug("debug image relay")
//            .distinctUntilChanged()
//            .flatMap { image -> Single<Void> in
//
//                guard let data = image.pngData() else {
//                    assertionFailure("cannot convert image to Data")
//                    return Single.just(())
//                }
//                let filePath = UUID().uuidString.lowercased()
//                GoogleCloudStorageUploader.uploadFile(data, filePath: filePath)
//                return ProfileInteractor.shared.updateProfile(params: ["profile_image_url": filePath])
//            }
//            .subscribe(onNext: { [unowned self] in
//                self.popFromNavigationController(animated: true)
//            })
//            .disposed(by: self.disposeBag)
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
