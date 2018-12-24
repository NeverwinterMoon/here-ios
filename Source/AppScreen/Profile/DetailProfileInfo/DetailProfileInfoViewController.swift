//
//  DetailProfileInfoViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import AppExtensions
import AppUIKit
import FlexLayout
import Nuke
import RxCocoa
import RxDataSources
import RxSwift

final class DetailProfileInfoViewController: UIViewController, DetailProfileInfoViewInterface, UICollectionViewDelegate {
    
    var presenter: DetailProfileInfoPresenterInterface!
    
    var tapChangeProfileImage: Signal<Void> {
        
        return self.changeProfileImageButton.rx.tap.asSignal()
    }
    
    var tapEditProfileRow: Signal<IndexPath> {
        
        return self.profileInfoCollectionView.rx.itemSelected.asSignal()
    }
    
    func update() {

        self.presenter.userProfileImage
            .drive(onNext: { [unowned self] in
                self.profileImageView.image = $0
            })
            .disposed(by: self.disposeBag)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.profileInfoCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.profileInfoCollectionViewFlowLayout)

        let dataSource = RxCollectionViewSectionedReloadDataSource<EditProfileInfoSection>(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            
            collectionView.register(DetailProfileInfoCell.self, forCellWithReuseIdentifier: "EditProfileInfoCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditProfileInfoCell", for: indexPath) as! DetailProfileInfoCell
            cell.title = item.type.displayTitle
            cell.content = item.body
            if item.type.infoType == .username {
                cell.content = "@\(String(describing: item.body))"
            } else {
                cell.content = item.body
            }
            return cell
        })
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

        self.profileInfoCollectionView.do {
            
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = true
            $0.backgroundColor = .white
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.profileInfoCollectionViewFlowLayout.do {
            
            $0.cellWidth = self.view.bounds.width
            $0.cellHeight = 50
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
    private let profileInfoCollectionView: UICollectionView
    private let profileInfoCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<EditProfileInfoSection>
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.alignItems(.center).define { flex in
            
            flex.addItem(self.profileImageView).size(80).marginTop(40).marginBottom(20)
            flex.addItem(self.changeProfileImageButton).alignSelf(.stretch).height(30).marginHorizontal(50)
            flex.addItem(self.profileInfoCollectionView).grow(1).width(self.view.bounds.width).marginTop(50).marginBottom(0)
        }
    }
}
