//
//  WatchingPlacesViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FlexLayout

final class WatchingPlacesViewController: UIViewController, WatchingPlacesViewInterface {
    
    var presenter: WatchingPlacesPresenterInterface!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private func flexLayout() {
        
    }
}
