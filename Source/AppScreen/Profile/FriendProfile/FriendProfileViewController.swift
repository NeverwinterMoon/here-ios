//
//  FriendProfileViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift

final class FriendProfileViewController: UIViewController, FriendProfileViewInterface {

    var presenter: FriendProfilePresenterInterface!
    
    var tapFriends: Signal<Void> {
        
        return self.friendsButton.rx.tap.asSignal()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.friendsButton.do {
            $0.backgroundColor = .black
        }
        
//        self.profileImageView.do {
//            $0.image =
//        }
        
        self.friendRequestButton.do {
            
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 2
        }
        
        self.userDisplayNameLabel.do {
            
            $0.backgroundColor = .white
            $0.font.withSize(20)
            
            self.presenter.userDisplayName.drive(onNext: {
                self.userDisplayNameLabel.text = $0
            })
            .disposed(by: self.disposeBag)
        }
        
        self.introLabel.do {
            
            $0.backgroundColor = .white
            
            self.presenter.userIntro.drive(onNext: {
                self.introLabel.text = $0
            })
            .disposed(by: self.disposeBag)
        }
        
        self.chatButton.do {
            $0.backgroundColor = .white
        }

        self.presenter.relation.drive(onNext: {
            switch $0 {
            case .friend:
                self.friendRequestButton.do {
                    $0.backgroundColor = .white
                    $0.setTitle("友達", for: .normal)
                    $0.setTitleColor(.blue, for: .normal)
                    $0.layer.borderColor = UIColor.blue.cgColor
                }
                self.chatButton.isHidden = false
            case .notFriend:
                self.friendRequestButton.do {
                    $0.backgroundColor = .blue
                    $0.setTitle("友達申請する", for: .normal)
                    $0.setTitleColor(.white, for: .normal)
                    $0.layer.borderColor = UIColor.blue.cgColor
                }
                self.chatButton.isHidden = true
            case .blocking:
                self.friendRequestButton.do {
                    $0.backgroundColor = .red
                    $0.setTitle("ブロックしています", for: .normal)
                    $0.setTitleColor(.white, for: .normal)
                    $0.layer.borderColor = UIColor.red.cgColor
                }
                self.chatButton.isHidden = true
            case .blocked:
                self.friendRequestButton.do {
                    $0.backgroundColor = .red
                    $0.setTitle("ブロックされています", for: .normal)
                    $0.setTitleColor(.white, for: .normal)
                    $0.layer.borderColor = UIColor.red.cgColor
                }
                self.chatButton.isHidden = true
            }
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
    private let friendsButton = UIButton()
    private let profileImageView = RoundImageView()
    private let userDisplayNameLabel = UILabel()
    private let introLabel = UILabel()
    private let friendRequestButton = UIButton()
    private let chatButton = UIButton()
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
                    flex.addItem().grow(1).direction(.column).define { flex in
                        flex.addItem(self.userDisplayNameLabel).marginTop(30).height(30)
                        flex.addItem(self.introLabel).height(40)
                    }
            }
            
            flex.addItem(self.friendRequestButton).alignSelf(.center).width(self.view.bounds.width - 2 * 30).height(30)
            
            flex.addItem(self.chatButton).size(100)
            flex.addItem(self.friendsButton).size(100)
        }
    }
}
