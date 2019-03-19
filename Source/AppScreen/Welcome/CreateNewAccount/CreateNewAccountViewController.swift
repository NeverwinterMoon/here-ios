//
//  CreateNewAccountViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift

final class CreateNewAccountViewController: UIViewController, CreateNewAccountViewInterface {
    
    var presenter: CreateNewAccountPresenterInterface!
    
    var tapCreateAccount: Signal<CreateUserInfo> {
        
        return self.createAccountButton.rx.tap.asSignal().map { [unowned self] in
            CreateUserInfo(
                email: self.emailTextField.text!,
                username: self.usernameTextField.text!,
                password: self.passwordTextField.text!
            )
        }
    }

    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        self.title = "新しいアカウント"
        
        self.emailTextField.do {
            
            $0.placeholder = "メールアドレス"
            $0.font = .systemFont(ofSize: 14)
        }
        
        self.usernameTextField.do {
            
            $0.placeholder = "ユーザー名"
            $0.font = .systemFont(ofSize: 14)
        }
        
        self.passwordTextField.do {

            $0.placeholder = "パスワード"
            $0.font = .systemFont(ofSize: 14)
        }
        
        self.createAccountButton.do {
            
            $0.backgroundColor = .blue
            $0.setTitle("アカウントを作成する", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        Observable.combineLatest(self.emailTextField.isNotEmpty, self.usernameTextField.isNotEmpty, self.passwordTextField.isNotEmpty) { $0 && $1 && $2 }
            .subscribe(onNext: { [unowned self] in
                self.createAccountButton.isEnabled = $0
            })
            .disposed(by: self.disposeBag)

        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let createAccountButton = AppButton()
    private let emailTextField = AppTextField()
    private let usernameTextField = AppTextField()
    private let passwordTextField = AppTextField()
    private let disposeBag = DisposeBag()
    
    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.emailTextField).marginHorizontal(20).marginTop(40).height(40)
            flex.addItem(self.usernameTextField).marginHorizontal(20).marginTop(40).height(40)
            flex.addItem(self.passwordTextField).marginHorizontal(20).marginTop(40).height(40)
            flex.addItem(self.createAccountButton).height(40).marginHorizontal(40).marginTop(40).height(40)
        }
    }
}
