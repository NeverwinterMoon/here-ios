//
//  EditUserInfoViewController.swift
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

final class EditUserInfoViewController: UIViewController, EditUserInfoViewInterface, UITableViewDelegate {
    
    var presenter: EditUserInfoPresenterInterface!
    
    var tapChangeProfileImage: Signal<Void> {
        
        return self.changeProfileImageButton.rx.tap.asSignal()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        let dataSource = RxTableViewSectionedReloadDataSource<EditProfileInfoSection>(
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
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        
        self.title = "プロフィールを編集"
        
        self.view.backgroundColor = .white
        
        self.changeProfileImageButton.do {
            
            $0.setTitle("プロフィール画像を変更", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
        }
        
        self.profileImageView.do {
//            tmp
            $0.backgroundColor = .blue
            
//            self.presenter.userProfileImageURL
//                .drive(onNext: { [unowned self] url in
//                    Nuke.loadImage(with: url, into: self.profileImageView)
//                })
//                .dispose(with: self)
        }
        
        self.profileInfoTableView.do {
            $0.delegate = self
            $0.register(EditProfileInfoCell.self, forCellReuseIdentifier: "ProfileInfoCell")
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = true
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let changeProfileImageButton = UIButton()
    private let profileImageView = UIImageView()
    private let profileInfoTableView: UITableView
    private let dataSource: RxTableViewSectionedReloadDataSource<EditProfileInfoSection>
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.alignItems(.center).define { flex in
            
            flex.addItem(self.profileImageView).size(80).marginTop(40).marginBottom(20)
            flex.addItem(self.changeProfileImageButton).alignSelf(.stretch).height(30).marginHorizontal(50)
            flex.addItem(self.profileInfoTableView).grow(1)
        }
    }
}
