//
//  MapViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/01.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import FirebaseFirestore
import RxCocoa
import RxSwift

final class MapViewController: UIViewController, MapViewInterface {
    
    var presenter: MapPresenterInterface!
    var docRef: DocumentReference!
    
    var t: Observable<Void> {
        return s.map { _ in }
    }
    var s = Observable.just("test")

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test
    }
}
