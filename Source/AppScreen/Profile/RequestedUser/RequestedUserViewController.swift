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

final class RequestedUserViewController: UIViewController, RequestedUserViewInterface, UICollectionViewDelegate {
    
    var presenter: RequestedUserPresenterInterface!
    
    var tapApproveRequest: Signal<IndexPath> {
        return self.tapApproveRequestRelay.asSignal()
    }
    
    private let tapApproveRequestRelay: PublishRelay<IndexPath> = .init()
    
    var tapDeclineRequest: Signal<IndexPath> {
        return self.tapDeclineRequestRelay.asSignal()
    }
    
    private let tapDeclineRequestRelay: PublishRelay<IndexPath> = .init()
    
    func resetDataSource() {
        
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource<RequestedUserSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            collectionView.register(RequestedUserCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RequestedUserCollectionViewCell.self))
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RequestedUserCollectionViewCell.self), for: indexPath) as! RequestedUserCollectionViewCell
            cell.item = item
            cell.tapApproveRequest
                .map { _ in indexPath }
                .emit(to: self.tapApproveRequestRelay)
                .disposed(by: self.disposeBag)
            
            cell.tapDeclineRequest
                .map { _ in indexPath }
                .emit(to: self.tapDeclineRequestRelay)
                .disposed(by: self.disposeBag)
            return cell
        })
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.collectionView = UICollectionView(frame: .init(), collectionViewLayout: self.collectionViewFlowLayout)
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource<RequestedUserSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RequestedUserCollectionViewCell.self), for: indexPath) as! RequestedUserCollectionViewCell
        })

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.resetDataSource()
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
        
        self.collectionViewFlowLayout.do {
            $0.cellHeight = 90
            $0.cellWidth = self.view.bounds.width
        }

        self.presenter.isRequestEmpty
            .drive(onNext: { [unowned self] in
                self.flexLayout(empty: $0)
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
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<RequestedUserSection>
    private let emptyViewLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    private func flexLayout(empty: Bool) {
        if empty {
            self.view.flex.define { flex in
                flex.addItem(self.emptyViewLabel).height(50).grow(1)
            }
            self.collectionView.removeFromSuperview()
        } else {
            self.view.flex.define { flex in
                flex.addItem(self.collectionView).grow(1)
            }
            self.emptyViewLabel.removeFromSuperview()
        }
    }
}
