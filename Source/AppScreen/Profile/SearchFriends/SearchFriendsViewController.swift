//
//  SearchFriendsViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppUIKit
import FlexLayout
import RxCocoa
import RxDataSources
import RxSwift

final class SearchFriendsViewController: UIViewController, SearchFriendsViewInterface, UISearchBarDelegate, UICollectionViewDelegate {
    
    var presenter: SearchFriendsPresenterInterface!
    
    var searchText: Driver<String> {
        
        return self.searchBar.rx.text.asDriver()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.searchedFriendsCollectoinView = UICollectionView(frame: .init(), collectionViewLayout: self.searchedFriendsCollectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<SearchFriendsSection> (configureCell: {(_, collectionView, indexPath, item) -> UICollectionViewCell in
            collectionView.register(SearchFriendsCell.self, forCellWithReuseIdentifier: "SearchFriendsCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFriendsCell", for: indexPath) as! SearchFriendsCell
            cell.item = item
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

        self.searchBar.do {
            
            $0.delegate = self
            $0.placeholder = "検索"
        }
        
        self.searchedFriendsCollectoinView.do {
            
            $0.delegate = self
            
            self.presenter.section
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
    private let searchBar = UISearchBar()
    private let searchedFriendsCollectoinView: UICollectionView
    private let searchedFriendsCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<SearchFriendsSection>
    private let disposeBag = DisposeBag()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.searchBar)
        }
    }
}
