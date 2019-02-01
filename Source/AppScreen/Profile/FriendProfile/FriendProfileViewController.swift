//
//  FriendProfileViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import FlexLayout
import RxCocoa

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
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let friendsButton = UIButton()
    
    private func flexLayout() {
        
    }
}
