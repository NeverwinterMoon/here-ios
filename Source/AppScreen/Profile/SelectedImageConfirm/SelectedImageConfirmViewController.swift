//
//  SelectedImageConfirmViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import RxCocoa
import RxSwift

final class SelectedImageConfirmViewController: UIViewController, SelectedImageConfirmViewInterface {
    
    var tapSelect: Signal<Void> {
        return self.selectButton.rx.tap.asSignal()
    }
    
    var tapCancel: Signal<Void> {
        return self.cancelButton.rx.tap.asSignal()
    }
    
    var presenter: SelectedImageConfirmPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter
            .selectedImage
            .drive(onNext: { [unowned self] in
                self.imageView.image = $0
            })
            .disposed(by: self.disposeBag)
        
        self.imageView.do {
            $0.contentMode = .scaleAspectFit
        }

        self.selectButton.do {
            $0.backgroundColor = .black
            $0.setTitle("選択", for: .normal)
        }
        
        self.cancelButton.do {
            $0.backgroundColor = .black
            $0.setTitle("キャンセル", for: .normal)
        }
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true

        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.marginTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let imageView = UIImageView()
    private let selectButton = UIButton()
    private let cancelButton = UIButton()
    private let disposeBag = DisposeBag()
    
    private func flexLayout() {
        
        self.view.flex.alignItems(.center).define { flex in
            
            flex.addItem(self.imageView).height(self.view.bounds.height - 100).width(self.view.bounds.width)
            flex.addItem().direction(.row).height(50).alignItems(.center).grow(1).define { flex in
                flex.addItem(self.cancelButton).width(150)
                flex.addItem(self.selectButton).width(150)
            }
        }
    }
}
