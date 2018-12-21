//
//  CameraRollViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import FlexLayout

final class CameraRollViewController: UIImagePickerController, CameraRollViewInterface {
    
    var presenter: CameraRollPresenterInterface!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        present(self.imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[.originalImage] as? UIImage {
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private
    private let imagePicker = UIImagePickerController()
}
