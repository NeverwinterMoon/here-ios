//
//  FriendsListViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class FriendsListViewController: UIViewController, FriendsListViewInterface, UITableViewDelegate {
    
    var presenter: FriendsListPresenterInterface!
    
    var tapFriend: Signal<IndexPath> {
        return self.tableView.rx.itemSelected.asSignal()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
//        tmp
        self.tableView = UITableView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - Private
    private let tableView: UITableView
}
