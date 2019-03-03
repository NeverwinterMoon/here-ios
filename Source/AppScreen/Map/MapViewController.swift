//
//  MapViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/01.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppEntity
import AppUIKit
import CoreLocation
import FirebaseFirestore
import RxCocoa
import RxDataSources
import RxSwift

final class MapViewController: UIViewController, MapViewInterface, CLLocationManagerDelegate {
    
    var presenter: MapPresenterInterface!
    var docRef: DocumentReference!
    
    var location: Signal<CLLocationCoordinate2D> {
        return self.locationRelay.asSignal()
    }
    
    private let locationRelay: PublishRelay<CLLocationCoordinate2D> = .init()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.nearbyFriendsCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.collectionViewFlowLayout)
        let dataSource = RxCollectionViewSectionedReloadDataSource<MapSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MapCollectionViewCell.self), for: indexPath) as! MapCollectionViewCell
            cell.item = item
            return cell
            })
        self.dataSource = dataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.title = "近くにいる友達"
        
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
//            self.checkLocationAuthorization()
        } else {
            
            // TODO:  show alert
        }
    }
    
    // MARK: - Private
    private let locationManager = CLLocationManager()
    private let collectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<MapSection>
    private let nearbyFriendsCollectionView: UICollectionView
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation = locations.last
        guard let currentLocation = latestLocation else {
            return
        }
        
        let coordinate = currentLocation.coordinate
        self.locationRelay.accept(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
}
