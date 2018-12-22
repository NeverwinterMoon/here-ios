//
//  SelectProfileImageViewModel.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import RxCocoa
import RxSwift

final class SelectProfileImagePresenter: SelectProfileImagePresenterInterface {

    let selectedImageRelay = BehaviorRelay<UIImage?>.init(value: nil)
    
    // TODO: bind image to selectedImageRelay and update the image with API.User.Update (save to google cloud platform with url)
    //       also, save it to local realm (do this part first, and GCP things would be done afterwards)
    func launchImagePicker(type: UIImagePickerController.SourceType, navigationController: UINavigationController) {
        
        UIImagePickerController.rx.createWithParent(navigationController) { picker in
            picker.sourceType = type
            picker.allowsEditing = true
            }
            .flatMap {
                $0.rx.didFinishPickingMediaWithInfo
            }
            .take(1)
            .map { info in
                info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            }
            .bind(to: self.selectedImageRelay)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
