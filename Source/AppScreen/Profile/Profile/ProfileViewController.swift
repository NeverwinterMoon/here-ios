//
//  ProfileViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppFoundation
import FlexLayout
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.do {
//            presenter gives this image
            $0.image = UIImage()
            $0.tintColor = .blue
            
//            tmp
            $0.backgroundColor = .blue
        }
        
        self.introTextView.do {
//            presenter gives this image
            $0.text = "testtest"
            $0.font?.withSize(14)
        }
        
        self.editProfileButton.do {
            
            $0.titleLabel?.text = "プロフィールを編集する"
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.black.cgColor
            // TODO ここを枠線ありのボタンにする
        }
        
        self.friendsButton.do {

            $0.titleLabel?.text = "友達"
            $0.titleLabel?.font.withSize(14)
            $0.backgroundColor = .blue
        }

        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let profileImageView = UIImageView()
    private let introTextView = UITextView()
    private let editProfileButton = UIButton()
    private let friendsButton = UIButton()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem()
                .height(150)
                .direction(.row)
                .alignItems(.center)
                .paddingHorizontal(40)
                .marginTop(40)
                .marginBottom(20)
                .define { flex in
                
                flex.addItem(self.profileImageView).size(80).marginRight(40)
                flex.addItem(self.introTextView).grow(1)
            }
            
            flex.addItem(self.editProfileButton).marginBottom(20)
            
            flex.addItem().height(100).define { flex in
                
                flex.addItem(self.friendsButton).grow(1).marginLeft(40)
            }
        }
    }
}
