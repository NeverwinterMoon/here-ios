//
//  WelcomeViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift

final class WelcomeViewController: UIViewController, WelcomeViewInterface {
    
    var presenter: WelcomePresenterInterface!

    var tapCreateNewAccount: Signal<Void> {
        
        return self.createNewAccountButton.rx.tap.asSignal()
    }
    
    var tapLogin: Signal<LoginInfo> {
        
        return self.loginButton.rx.tap
            .map { [unowned self] in
                LoginInfo(
                    usernameOrEmail: self.emailOrUsernameTextField.text!.trimmingCharacters(in: .whitespaces),
                    password: self.passwordTextField.text!.trimmingCharacters(in: .whitespaces)
                )
            }
            .asSignal(onErrorJustReturn: .init(usernameOrEmail: "", password: ""))
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        
        self.title = "ようこそ!"
        
        self.view.backgroundColor = .white
        
        self.welcomeLabel.do {
            
            $0.text = "hereへようこそ!"
            $0.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.init(30))
        }
        
        self.createNewAccountButton.do {
            
            $0.backgroundColor = .blue
            $0.setTitle("新規登録はこちら", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 20
        }

        self.emailOrUsernameTextField.do {
            
            $0.placeholder = "メールアドレス"
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        
        self.passwordTextField.do {
            
            $0.placeholder = "パスワード"
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        
        self.loginButton.do {
            
            $0.setTitle("ログイン", for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 20
        }
        
        self.forgotPasswordButton.do {
            
            $0.setTitleColor(.gray, for: .normal)
        }
        
        Observable.combineLatest(self.emailOrUsernameTextField.isNotEmpty, self.passwordTextField.isNotEmpty) { $0 && $1 }
            .subscribe { [unowned self] in
                self.loginButton.isEnabled = $0.element!
            }
            .disposed(by: self.disposeBag)

        self.flexLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let welcomeLabel = UILabel()
    private let createNewAccountButton = AppButton()
    private let emailOrUsernameTextField = AppTextField()
    private let passwordTextField = AppTextField()
    private let loginButton = AppButton()
    private let forgotPasswordButton = UIButton()
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.define { [unowned self] flex in
            
            flex.addItem(self.welcomeLabel).marginTop(50).height(100).marginHorizontal(20).alignSelf(.center)
            flex.addItem(self.createNewAccountButton).alignSelf(.stretch).height(40).marginHorizontal(40)
            
            flex.addItem(self.emailOrUsernameTextField).marginTop(40).marginHorizontal(20).height(40)
            flex.addItem(self.passwordTextField).marginTop(40).marginHorizontal(20).height(40)

            flex.addItem(self.loginButton).marginTop(40).marginHorizontal(40).height(40)
            flex.addItem(self.forgotPasswordButton).marginTop(30).marginHorizontal(60).height(30)
        }
    }
}
