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
    
    var presenter: WelcomePresenterInterface!

    var tapCreateNewAccount: Signal<Void> {
        
        return self.createNewAccountButton.rx.tap.asSignal()
    }
    
    var tapLogin: Signal<LoginInfo> {
        
        return self.loginButton.rx.tap
            .map { [unowned self] _ in
                LoginInfo(usernameOrEmail: self.emailOrUsernameTextField.text!, password: self.passwordTextField.text!)
            }
            .asSignal(onErrorJustReturn: .init(usernameOrEmail: "", password: ""))
    }
    
    private var emailOrUsernameIsEmpty: Observable<Bool> {
        return self.emailOrUsernameTextField.rx.attributedText.map { $0 == nil }.asObservable()
    }
    
    private var passwordIsEmpty: Observable<Bool> {
        return self.passwordTextField.rx.attributedText.map { $0 == nil }.asObservable()
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
        
        self.emailOrUsernameLabel.do {
            
            $0.text = "メールアドレス"
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .black
        }
        
        self.passwordLabel.do {
            
            $0.text = "パスワード"
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .black
        }
        
        self.emailOrUsernameTextField.do {
            
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
        
        self.loginButton.do {
            
            $0.setTitle("ログイン", for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 20
        }
        
        Observable.combineLatest(self.emailOrUsernameIsEmpty, self.passwordIsEmpty)
            .subscribe(onNext: {
                self.loginButton.isEnabled = $0 && $1
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
    private let welcomeLabel = UILabel()
    private let createNewAccountButton = UIButton()
    private let emailOrUsernameLabel = UILabel()
    private let emailOrUsernameTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let forgotPasswordButton = UIButton()
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.welcomeLabel).marginTop(50).height(100).marginHorizontal(20).alignSelf(.center)
            flex.addItem(self.createNewAccountButton).alignSelf(.stretch).height(40).marginHorizontal(20)
            
            flex.addItem().direction(.row).marginTop(40).marginHorizontal(20).height(50).define { flex in
                
                flex.addItem(self.emailOrUsernameLabel).width(80)
                flex.addItem(self.emailOrUsernameTextField).grow(1)
            }
            
            flex.addItem().direction(.row).marginTop(20).marginHorizontal(20).height(50).define { flex in
                
                flex.addItem(self.passwordLabel).width(80)
                flex.addItem(self.passwordTextField).grow(1)
            }
            
            flex.addItem(self.loginButton).marginTop(40).marginHorizontal(20).height(40)
        }
    }
}
