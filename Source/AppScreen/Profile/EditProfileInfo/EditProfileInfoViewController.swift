//
//  EditProfileInfoViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import AppExtensions
import AppUIKit
import RxCocoa
import RxSwift

final class EditProfileInfoViewController: UIViewController, EditProfileInfoViewInterface {
    
    var tapSaveProfileInfo: Signal<String> {
        
        return self.saveProfileInfoButton.rx.tap.asSignal().map { self.editInfoTextField.text! }
    }

    var presenter: EditProfileInfoPresenterInterface!

    override func viewDidLoad() {
        
        self.presenter.infoToChange.drive(onNext: {
            self.title = $0
            self.infoInChangeLabel.text = $0
        })
        .disposed(by: self.disposeBag)
        
        self.presenter.currentInfo.drive(onNext: {
            self.editInfoTextField.text = $0
        })
        .disposed(by: self.disposeBag)

        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = self.saveProfileInfoButton

        super.viewDidLoad()
        
        self.infoInChangeLabel.do {
            
            $0.textAlignment = .center
        }
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }

    // MARK: - Private
    private let saveProfileInfoButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
    private let disposeBag = DisposeBag()
    private let infoInChangeLabel = UILabel()
    private let editInfoTextField = AppTextField()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem().direction(.row).marginTop(80).define { flex in
                
                flex.addItem(self.infoInChangeLabel).height(60).width(150)
                flex.addItem(self.editInfoTextField).height(60).grow(1)
            }
        }
    }
}
