//
//  FriendsListViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import RxCocoa
import RxDataSources
import RxSwift

final class FriendsListViewController: UIViewController, FriendsListViewInterface, UICollectionViewDelegate {
    
    var presenter: FriendsListPresenterInterface!
    
    var tapFriend: Signal<IndexPath> {
        return self.friendsCollectionView.rx.itemSelected.asSignal()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.friendsCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.friendsCollectionViewFlowlayout)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<FriendsListSection>(configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            
            collectionView.register(FriendsListCell.self, forCellWithReuseIdentifier: "FriendsListCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsListCell", for: indexPath) as! FriendsListCell
            cell.profileImageData = item.profileImageFilePath
            cell.userDisplayName = item.userDisplayName
            cell.username = item.username
            return cell
        })
        self.dataSource = dataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.friendsCollectionView.do {
            
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = true
            $0.backgroundColor = .white
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.friendsCollectionViewFlowlayout.do {
            
            $0.cellWidth = self.view.bounds.width
            $0.cellHeight = 50
        }
    }

    // MARK: - Private
    private let friendsCollectionView: UICollectionView
    private let friendsCollectionViewFlowlayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<FriendsListSection>
    private let disposeBag = DisposeBag()
}
