//
//  CameraRollViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class CameraRollViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var viewModel: CameraRollViewModel!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white

        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            self.imagePickerController.delegate = self
            self.imagePickerController.sourceType = .savedPhotosAlbum
            self.imagePickerController.allowsEditing = false
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[.originalImage] as? UIImage {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private
    private let imagePickerController = UIImagePickerController()
    private let imageView = UIImageView()
}
