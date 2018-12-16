//
//  ProfileViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppExtensions
import AppUIKit
import FlexLayout
import Nuke
import RxCocoa
import RxSwift

final class ProfileViewController: UIViewController, ProfileViewInterface {
    
    var presenter: ProfilePresenterInterface!
    
    var tapEditProfile: Signal<Void> {
        
        return self.editProfileButton.rx.tap.asSignal()
    }
    
    var tapFriends: Signal<Void> {
        
        return self.friendsButton.rx.tap.asSignal()
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
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
//        self.title = "Profile"
        self.presenter.username.drive(onNext: {
            self.title = $0
        }).disposed(by: self.disposeBag)
        
        self.presenter.userDisplayName.drive(onNext: { [unowned self] in
            self.userDisplayNameLabel.text = $0
        })
        .disposed(by: self.disposeBag)
        
        self.presenter.username.drive(onNext: { [unowned self] in
            self.usernameLabel.text = $0
        })
        .disposed(by: self.disposeBag)
        
        self.presenter.selfIntroduction.drive(onNext: { [unowned self] in
            self.introLabel.text = $0
        })
        .disposed(by: self.disposeBag)
        
        self.profileImageView.do {
//            tmp
            $0.backgroundColor = .blue
            
//            self.presenter.profileImageURL
//                .drive(onNext: { [unowned self] url in
//
//                    Nuke.loadImage(with: url, into: self.profileImageView)
//                })
//                .dispose(with: self)
        }
        
        self.userDisplayNameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = .black
            
        }
        
        self.usernameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.textColor = .black
            
            self.presenter
                .username
                .drive(onNext: { [unowned self] in
                    self.usernameLabel.text = $0
                })
                .disposed(by: self.disposeBag)
        }
        
        self.introLabel.do {
            
            $0.font?.withSize(14)
            
            self.presenter
                .selfIntroduction
                .drive(onNext: { [unowned self] in
                    self.introLabel.text = $0
                })
                .disposed(by: self.disposeBag)
        }
        
        self.editProfileButton.do {
            
            $0.setTitle("プロフィールを編集する", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
        }
        
        self.friendsIconImageView.do {
            // tmp
            $0.backgroundColor = .orange
        }
        
        self.friendsButton.do {

            $0.setTitle("友達", for: .normal)
            $0.backgroundColor = .blue
        }

        self.flexLayout()
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let profileImageView = UIImageView()
    private let userDisplayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let introLabel = UILabel()
    private let editProfileButton = UIButton()
    private let friendsButton = AppButton()
    private let friendsIconImageView = UIImageView()
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem()
                .height(150)
                .direction(.row)
                .alignItems(.center)
                .paddingHorizontal(40)
                .marginBottom(20)
                .define { flex in
                    flex.addItem(self.profileImageView).size(80).marginRight(40)
                    flex.addItem().define { flex in
                        flex.addItem(self.userDisplayNameLabel).height(30).width(100)
                        flex.addItem(self.usernameLabel).height(20).width(100)
                    }
                    flex.addItem(self.introLabel)
            }
            
            flex.addItem(self.editProfileButton).marginHorizontal(50).marginBottom(20).height(30)
            
            flex.addItem().height(100).direction(.row).define { flex in
                
                flex.addItem(self.friendsIconImageView).width(80)
                flex.addItem(self.friendsButton).grow(1)
            }
        }
    }
}
