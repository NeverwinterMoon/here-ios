//
//  SelectProfileImageAlertSheet.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SelectProfileImageAlertSheet: UIAlertController, UIImagePickerControllerDelegate, SelectProfileImageViewInterface {
    
    var presenter: SelectProfileImagePresenterInterface!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.addAction(UIAlertAction(title: "写真を撮る", style: .default, handler: { (action) in
        }))
        
        self.addAction(UIAlertAction(title: "カメラロールから選択する", style: .default, handler: { [unowned self] _ in
            self.presenter.selectProfileImageFromCameraRoll()
        }))
        
        self.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
}
