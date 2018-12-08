//
//  CreateNewAccountViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import FlexLayout
import RxCocoa

final class CreateNewAccountViewController: UIViewController, CreateNewAccountViewInterface {
    
    var presenter: CreateNewAccountPresenterInterface!
    
    var tapCreateAccount: Signal<Void> {
        
        return self.createAccountButton.rx.tap.asSignal()
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        self.title = "新しいアカウント"
        
        self.emailLabel.do {
            
            $0.text = "メールアドレス"
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .black
        }
        
        self.passwordLabel.do {
            
            $0.text = "パスワード"
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .black
        }
        
        self.emailTextField.do {
            
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 10
        }
        
        self.passwordTextField.do {
            
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 10
            
            // TODO: customize textfield to close cursor when tapped outside of textfield (maybe make custom class??)
        }
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let createAccountButton = UIButton()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    
    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.createAccountButton)
        }
    }
}
