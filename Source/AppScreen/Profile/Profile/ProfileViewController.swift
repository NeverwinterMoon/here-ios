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

final class ProfileViewController: UIViewController, ProfileViewInterface, UICollectionViewDelegate, UIScrollViewDelegate {
    
    var presenter: ProfilePresenterInterface!
    
    var tapProfileRow: Signal<IndexPath> {
        
        return self.profileCollectionView.rx.itemSelected.asSignal()
    }

    // TODO: fix here!!
    func update() {
        
        self.presenter.username
            .drive(onNext: { [unowned self] in
                self.usernameLabel.text = "@\($0)"
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
            let identifier = String(describing: ProfileCollectionViewCell.self)
            collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProfileCollectionViewCell
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
        
        self.title = "プロフィール"
        
        self.view.backgroundColor = .white

        self.userDisplayNameLabel.do {
            $0.font = .systemFont(ofSize: 30, weight: .init(5))
            $0.textAlignment = .center
        }
        
        self.usernameLabel.do {
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .center
        }

        self.introLabel.do {
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .center
        }
        
        self.profileCollectionView.do {
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.backgroundColor = .white
            $0.isScrollEnabled = false

            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.profileCollectionViewFlowLayout.do {
            $0.cellWidth = self.view.bounds.width
            $0.cellHeight = 50
        }
        
        self.containerScrollView.do {
            $0.delegate = self
            $0.contentSize = CGSize(width: self.view.bounds.width, height: 380 + self.profileCollectionViewFlowLayout.cellHeight * 4)
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        self.flexLayout()
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let containerScrollView = UIScrollView()
    private let profileImageView = RoundImageView()
    private let userDisplayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let introLabel = UILabel()
    private let profileCollectionView: UICollectionView
    private let profileCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<ProfileSection>
    private let disposeBag = DisposeBag()
    // TODO: editProfileButtonやfriendsButtonを用意して、collectionViewの代わりに丸いbuttonを4つ並べるのもいいかも

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.containerScrollView).grow(1).define { flex in

                flex.addItem(self.profileImageView).size(150).marginTop(70).alignSelf(.center)
                flex.addItem(self.userDisplayNameLabel).height(40).marginTop(10).alignSelf(.center)
                flex.addItem(self.usernameLabel).height(30).alignSelf(.center)
                flex.addItem(self.introLabel).height(40).marginTop(10).alignSelf(.center)
                flex.addItem(self.profileCollectionView).grow(1).marginTop(30)
            }
        }
    }
}
