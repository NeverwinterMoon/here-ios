//
//  ChatRoomListViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift
import RxDataSources

final class ChatRoomListViewController: UIViewController, ChatRoomListViewInterface {
    
    var presenter: ChatRoomListPresenterInterface!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.chatRoomListCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.chatRoomListCollectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<ChatRoomListSection> ( configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatRoomListCell", for: indexPath) as! ChatRoomListCollectionViewCell
            cell.item = item
            return cell
        })
        self.dataSource = dataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.chatRoomListCollectionViewFlowLayout.do {
            $0.cellHeight = 50
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
    private let chatRoomListCollectionView: UICollectionView
    private let chatRoomListCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<ChatRoomListSection>
}
