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

final class WatchingPlacesViewController: UIViewController, WatchingPlacesViewInterface {
    
    var presenter: WatchingPlacesPresenterInterface!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.flexLayout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let watchingPlacesCollectionView: UICollectionView
    private let watchingPlacesCollectionViewFlowLayout = AppCollectionViewFlowLayout()
    
    private func flexLayout() {
        
    }
}
