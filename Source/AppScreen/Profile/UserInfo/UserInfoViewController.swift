//
//  UserInfoViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import AppExtensions
import FlexLayout
import Nuke
import RxCocoa
import RxDataSources
import RxSwift

final class UserInfoViewController: UIViewController, UserInfoViewInterface, UITableViewDelegate {
    
    var presenter: UserInfoPresenterInterface!
    
    var tapChangeProfileImage: Signal<Void> {
        
        return self.changeProfileImageButton.rx.tap.asSignal()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        let dataSource = RxTableViewSectionedReloadDataSource<ProfileInfoSection>(
            configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath)
                cell.textLabel?.text = item.title
                return cell
        })
        
//        tmp
        self.profileInfoTableView = UITableView()
        self.dataSource = dataSource

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
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
        
        self.profileInfoTableView.do {
            $0.delegate = self
            $0.register(ProfileInfoCell.self, forCellReuseIdentifier: "ProfileInfoCell")
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = true
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
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
    private let profileInfoTableView: UITableView
    private let dataSource: RxTableViewSectionedReloadDataSource<ProfileInfoSection>

    private func flexLayout() {
        
    }
}
