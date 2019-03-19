//
//  MapViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/01.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppEntity
import AppExtensions
import AppUIKit
import CoreLocation
import FirebaseFirestore
import RxCocoa
import RxDataSources
import RxSwift

final class MapViewController: UIViewController, MapViewInterface, CLLocationManagerDelegate, UICollectionViewDelegate {
    
    var presenter: MapPresenterInterface!
    var docRef: DocumentReference!
    
    var location: Signal<CLLocationCoordinate2D> {
        return self.locationRelay.asSignal()
    }
    
    private let locationRelay: PublishRelay<CLLocationCoordinate2D> = .init()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.nearbyFiendsCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.collectionViewFlowLayout)
        let nearbyFriendsDataSource = RxCollectionViewSectionedReloadDataSource<MapNearbyFriendsSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MapCollectionViewCell.self), for: indexPath) as! MapCollectionViewCell
            cell.item = item
            return cell
            })
        self.nearbyFriendsDataSource = nearbyFriendsDataSource
        
        self.nearSpotFriendsCollectionView = UICollectionView(frame: .init(), collectionViewLayout: self.collectionViewFlowLayout)
        let nearSpotFriendsDataSource = RxCollectionViewSectionedReloadDataSource<MapNearSpotFriendsSection> (configureCell: { (_, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MapCollectionViewCell.self), for: indexPath) as! MapCollectionViewCell
            cell.item = item
            return cell
            })
        self.nearSpotFriendsDataSource = nearSpotFriendsDataSource
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.title = "近くにいる友達"
        
        super.viewDidLoad()
        
        self.locationManager.delegate = self

        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                self.locationManager.do {
                    $0.distanceFilter = 100
                    $0.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    $0.startUpdatingLocation()
                }
            case .authorizedWhenInUse:
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.do {
                    $0.distanceFilter = 100
                    $0.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    $0.startUpdatingLocation()
                }
            case .denied, .notDetermined, .restricted:
                // TODO: show alert
                self.locationManager.requestWhenInUseAuthorization()
            }
        } else {
            // TODO: show alert
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        self.nearbyFiendsCollectionView.do {
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.isScrollEnabled = false
            $0.backgroundColor = .white
            
            self.presenter.nearbyFriendsSections
                .drive($0.rx.items(dataSource: self.nearbyFriendsDataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.nearSpotFriendsCollectionView.do {
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.isScrollEnabled = false
            $0.backgroundColor = .white
            
            self.presenter.nearSpotFriendsSections
                .drive($0.rx.items(dataSource: self.nearSpotFriendsDataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.flexLayout(isNearbyFriendsEmpty: false, isNearSpotFriendsEmpty: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
        self.view.flex.paddingBottom(self.view.safeAreaInsets.bottom)
        self.view.flex.layout()
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // argument "locations" have at least one CLLocation
        let coordinate = locations.last!.coordinate
        self.locationRelay.accept(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
        case .denied, .notDetermined, .restricted:
            self.locationManager.stopUpdatingLocation()
        }
    }

    // MARK: - Private
    private let locationManager = CLLocationManager()
    private let collectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let disposeBag = DisposeBag()
    private let nearbyFriendsDataSource: RxCollectionViewSectionedReloadDataSource<MapNearbyFriendsSection>
    private let nearSpotFriendsDataSource: RxCollectionViewSectionedReloadDataSource<MapNearSpotFriendsSection>
    private let nearbyFiendsCollectionView: UICollectionView
    private let nearSpotFriendsCollectionView: UICollectionView
    private let nearbyFriendsTitleLabel = UILabel()
    private let nearSpotFriendsTitleLabel = UILabel()

    private func flexLayout(isNearbyFriendsEmpty: Bool, isNearSpotFriendsEmpty: Bool) {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.nearbyFiendsCollectionView).grow(1)
            flex.addItem(self.nearSpotFriendsCollectionView).grow(1)
        }
    }
}
