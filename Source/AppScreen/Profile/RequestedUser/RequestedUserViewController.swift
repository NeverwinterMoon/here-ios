//
//  RequestedUserViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppUIKit
import FlexLayout
import RxDataSources
import RxCocoa
import RxSwift

final class RequestedUserViewController: UIViewController, RequestedUserViewInterface {
    
    var presenter: RequestedUserPresenterInterface!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.collectionView = UICollectionView(frame: .init(), collectionViewLayout: self.collectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<RequestedUserSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            collectionView.register(RequestedUserCollectionViewCell.self, forCellWithReuseIdentifier: "RequestedUserCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestedUserCell", for: indexPath) as! RequestedUserCollectionViewCell
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

        self.title = "友達申請"
        self.view.backgroundColor = .white
        
        self.collectionView.do {
            $0.backgroundColor = .white
            
            self.presenter.sections
                .drive($0.rx.items(dataSource: self.dataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.emptyViewLabel.do {
            $0.text = "友達申請はありません"
            $0.textColor = .gray
            $0.textAlignment = .center
        }
        
        self.presenter.sections.drive(onNext: { [unowned self] in
            self.flexLayout(empty: $0.isEmpty)
        })
        .disposed(by: self.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
    }

    // MARK: - Private
    private let collectionView: UICollectionView
    private let collectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<RequestedUserSection>
    private let emptyViewLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    private func flexLayout(empty: Bool) {
        if empty {
            self.view.flex.define { flex in
                flex.addItem(self.emptyViewLabel).alignSelf(.center).marginTop(80)
            }
        } else {
            self.view.flex.define { flex in
                flex.addItem(self.collectionView).grow(1)
            }
        }
    }
}
