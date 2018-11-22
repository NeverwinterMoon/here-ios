//
//  UserInfoViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import Nuke
import RxCocoa
import RxDataSources
import RxSwift

final class UserInfoViewController: UIViewController, UserInfoViewInterface {
    
    var presenter: UserInfoPresenterInterface
    
    var tapChangeProfileImage: Signal<Void> {
        
        self.changeProfileImageButton.rx.tap.asSignal()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        
        self.changeProfileImageButton.do {
            
            $0.titleLabel?.textColor = .blue
        }
        
        self.profileImageView.do {
//            tmp
            $0.backgroundColor = .blue
            
            self.presenter.userProfileImageURL
                .drive(onNext: { [unowned self] url in
                    Nuke.loadImage(with: url, into: self.profileImageView)
                })
                .dispose(with: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let changeProfileImageButton = UIButton()
    private let profileImageView = UIImageView()
    private let profileInfoTableView = UITableView()

    private func flexLayout() {
        
    }
}
