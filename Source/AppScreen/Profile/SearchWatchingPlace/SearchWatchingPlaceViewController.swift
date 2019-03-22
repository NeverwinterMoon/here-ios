//
//  SearchWatchingPlaceViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/22.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FlexLayout
import MapKit
import RxCocoa
import RxSwift

final class SearchWatchingPlaceViewController: UIViewController, SearchWatchingPlaceViewInterface {
    
    var presenter: SearchWatchingPlacePresenterInterface!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let mapView = MKMapView()
    
    private func flexLayout() {
        
        self.view.flex.define { flex in
            flex.addItem(self.mapView).grow(1)
        }
    }
}
