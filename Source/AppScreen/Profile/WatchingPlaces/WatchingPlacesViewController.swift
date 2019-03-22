//
//  WatchingPlacesViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import FlexLayout
import RxDataSources
import RxCocoa
import RxSwift

final class WatchingPlacesViewController: UIViewController, WatchingPlacesViewInterface, UICollectionViewDelegate {
    
//    var tapAddWatchingPlace: Signal<Void> {
//        return self.tapAddWatchingPlaceRelay.asSignal()
//    }
//
//    private let tapAddWatchingPlaceRelay: PublishRelay<Void> = .init()
    var tapAddWatchingPlace: Signal<Void> {
        return self.addCreateWatchingPlaceItem.rx.tap.asSignal()
    }
    
    var presenter: WatchingPlacesPresenterInterface!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.watchingPlacesCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.watchingPlacesCollectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<WatchingPlacesSection>(configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            let identifier = String(describing: WatchingPlacesCollectionViewCell.self)
            collectionView.register(WatchingPlacesCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WatchingPlacesCollectionViewCell
            cell.item = item
            return cell
            })
        self.dataSource = dataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "登録した場所"
        
        self.view.backgroundColor = .white
        
//        if let target = self.addCreateWatchingPlace.target, let action = self.addCreateWatchingPlace.action {
//
//        }
        
        self.navigationItem.rightBarButtonItem = self.addCreateWatchingPlaceItem

        self.watchingPlacesCollectionView.do {
            $0.backgroundColor = .white
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.isScrollEnabled = false
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.watchingPlacesCollectionViewFlowLayout.do {
            $0.cellWidth = self.view.bounds.width
            $0.cellHeight = 100
        }
        
        self.watchingPlacesEmptyLabel.do {
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 14)
        }
        
        self.presenter.sections
            .drive(onNext: { [unowned self] in
                if let items = $0.first?.items {
                    self.flexLayout(isViewEmpty: items.isEmpty)
                } else {
                    self.flexLayout(isViewEmpty: true)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let addCreateWatchingPlaceItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    private let dataSource: RxCollectionViewSectionedReloadDataSource<WatchingPlacesSection>
    private let disposeBag = DisposeBag()
    private let watchingPlacesCollectionView: UICollectionView
    private let watchingPlacesCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let watchingPlacesEmptyLabel = AppLabel(text: "登録した場所はありません")

    private func flexLayout(isViewEmpty: Bool) {
        
        self.view.flex.define { flex in
            
            if isViewEmpty {
                flex.addItem(self.watchingPlacesEmptyLabel).grow(1)
                self.watchingPlacesCollectionView.removeFromSuperview()
            } else {
                flex.addItem(self.watchingPlacesCollectionView).grow(1)
                self.watchingPlacesEmptyLabel.removeFromSuperview()
            }
        }
    }
}
