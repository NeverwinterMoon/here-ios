//
//  WelcomeViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import FlexLayout
import RxCocoa
import RxSwift

final class WelcomeViewController: UIViewController, WelcomeViewInterface {

    var tapCreateNewAccount: Signal<Void> {
        
        return self.createNewAccountButton.rx.tap.asSignal()
    }
    
    var tapLogIn: Signal<Void> {
        
        return self.logInButton.rx.tap.asSignal()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        
        self.welcomeLabel.do {
            
            $0.text = "hereへようこそ!"
            $0.font.withSize(25)
        }
        
        self.createNewAccountButton.do {
            
            $0.backgroundColor = .blue
            $0.setTitle("新規登録はこちら", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        self.emailLabel.do {
            
            $0.text = "メールアドレス"
        }
        
        self.passWordLabel.do {
            
            $0.text = "パスワード"
        }
        
        self.emailTextField.do {
            
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        self.passWordTextField.do {
            
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        self.logInButton.do {
            
            $0.setTitle("ログイン", for: .normal)
            $0.backgroundColor = .blue
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexLayout()
    }
    
    // MARK: - Private
    private let welcomeLabel = UILabel()
    private let createNewAccountButton = UIButton()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passWordLabel = UILabel()
    private let passWordTextField = UITextField()
    private let logInButton = UIButton()
    private let forgotPassWordButton = UIButton()

    private func flexLayout() {
        
        self.view.flex.alignItems(.center).define { flex in
            
            flex.addItem(self.welcomeLabel).marginTop(50).height(100).marginHorizontal(20)
            flex.addItem(self.createNewAccountButton).alignSelf(.stretch).height(40).marginHorizontal(20)
            
            flex.addItem().direction(.row).marginHorizontal(20).height(50).define { flex in
                
                flex.addItem(self.emailLabel).width(0.3)
                flex.addItem(self.emailTextField).grow(1)
            }
            
            flex.addItem().direction(.row).marginHorizontal(20).height(50).define { flex in
                
                flex.addItem(self.passWordLabel).width(0.3)
                flex.addItem(self.passWordTextField).grow(1)
            }
        }
    }
}
