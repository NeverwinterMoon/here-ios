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
import RxDataSources
import RxSwift

final class ProfileViewController: UIViewController, ProfileViewInterface, UICollectionViewDelegate {
    
    var presenter: ProfilePresenterInterface!
    
    var tapEditProfile: Signal<Void> {
        
        return self.editProfileButton.rx.tap.asSignal()
    }
    
    var tapProfileRow: Signal<IndexPath> {
        
        return self.profileCollectionView.rx.itemSelected.asSignal()
    }

    func update() {
        
        self.presenter.username
            .drive(onNext: { [unowned self] in
                self.title = $0
            })
            .disposed(by: self.disposeBag)
        
        self.presenter.userDisplayName
            .drive(onNext: { [unowned self] in
                self.userDisplayNameLabel.text = $0
            })
            .disposed(by: self.disposeBag)
        
        self.presenter.selfIntroduction
            .drive(onNext: { [unowned self] in
                self.introLabel.text = $0
            })
            .disposed(by: self.disposeBag)
        
        self.presenter.profileImage
            .drive(onNext: { [unowned self] in
                self.profileImageView.image = $0
            })
            .disposed(by: self.disposeBag)
    }
    
    convenience init() {
        
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.profileCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.profileCollectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<ProfileSection>(configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.item = item
            return cell
        })
        self.dataSource = dataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        //TODO: 裏でusernameとかselfIntroductionとかをサーバーから取ってくる。Realmはそれまでの間だけ表示させておく
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.userDisplayNameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 30)
            $0.textColor = .black
        }
        
        self.introLabel.do {
            
            $0.font?.withSize(14)
            $0.font = UIFont.systemFont(ofSize: 20)
        }
        
        self.editProfileButton.do {
            
            $0.setTitle("プロフィールを編集する", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
        }
        
        self.profileCollectionView.do {
            
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.backgroundColor = .white
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.profileCollectionViewFlowLayout.do {
            
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
    private let profileImageView = RoundImageView()
    private let userDisplayNameLabel = UILabel()
    private let introLabel = UILabel()
    private let editProfileButton = UIButton()
    private let profileCollectionView: UICollectionView
    private let profileCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<ProfileSection>
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
                        flex.addItem(self.userDisplayNameLabel).marginTop(30).height(50)
                        flex.addItem(self.introLabel).height(40)
                    }
            }
            
            flex.addItem(self.editProfileButton).marginHorizontal(50).marginBottom(20).height(30)
            flex.addItem(self.profileCollectionView).grow(1)
        }
    }
}
