//
//  SelectProfileImageAlertSheet.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppUIKit
import RxCocoa
import RxMediaPicker
import RxSwift

final class SelectProfileImageViewController: UIAlertController, UIImagePickerControllerDelegate, SelectProfileImageViewInterface {
    
    var presenter: SelectProfileImagePresenterInterface!
    var tapCameraRoll: Signal<Void> {
        return self.tapCameraRollRelay.asSignal(onErrorJustReturn: ())
    }
    private var tapCameraRollRelay: BehaviorRelay<Void> = .init(value: ())
    
    var tapCamera: Signal<Void> {
        return self.tapCameraRelay.asSignal(onErrorJustReturn: ())
    }
    private var tapCameraRelay: BehaviorRelay<Void> = .init(value: ())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addAction(UIAlertAction(title: "カメラロールから選択", style: .default, handler: { _ in
            self.tapCameraRollRelay.accept(())
        }))
        self.addAction(UIAlertAction(title: "写真を撮影する", style: .default, handler: { _ in
            self.tapCameraRelay.accept(())
        }))
        self.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
    }
    
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
