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
        
        super.viewDidLoad()
        
        self.locationManager.delegate = self

        if let navigationController = self.navigationController {
            navigationController.isNavigationBarHidden = true
        }

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
            $0.backgroundColor = .gray
            
            self.presenter.nearbyFriendsSections
                .drive($0.rx.items(dataSource: self.nearbyFriendsDataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.nearSpotFriendsCollectionView.do {
            $0.delegate = self
            $0.alwaysBounceVertical = true
            $0.isScrollEnabled = false
            $0.backgroundColor = .gray
            
            self.presenter.nearSpotFriendsSections
                .drive($0.rx.items(dataSource: self.nearSpotFriendsDataSource))
                .disposed(by: self.disposeBag)
        }
        
        self.nearbyFriendsTitleLabel.do {
            $0.text = "近くにいる友達"
            $0.font = .systemFont(ofSize: 20, weight: .init(5))
        }
        
        self.nearSpotFriendsTitleLabel.do {
            $0.text = "登録した場所の近くにいる友達"
            $0.font = .systemFont(ofSize: 20, weight: .init(5))
        }
        
        self.nearbyFriendsView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 30
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowRadius = 10
        }
        
        self.nearSpotFriendsView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 30
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowRadius = 10
        }
        
        Observable.zip(self.presenter.nearbyFriendsSections.asObservable(), self.presenter.nearSpotFriendsSections.asObservable())
            .take(1)
            .subscribe(onNext: { [unowned self] in
                self.flexLayout(isNearbyFriendsEmpty: $0.0.isEmpty, isNearSpotFriendsEmpty: $0.1.isEmpty)
            })
            .disposed(by: self.disposeBag)
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
    private let collectionViewFlowLayout = AppCollectionViewFlowLayout()
    private let disposeBag = DisposeBag()
    private let locationManager = CLLocationManager()
    
    private let nearbyFiendsCollectionView: UICollectionView
    private let nearbyFriendsDataSource: RxCollectionViewSectionedReloadDataSource<MapNearbyFriendsSection>
    private let nearbyFriendsTitleLabel = UILabel()
    private let nearbyFriendsView = UIView()
    
    private let nearSpotFriendsCollectionView: UICollectionView
    private let nearSpotFriendsDataSource: RxCollectionViewSectionedReloadDataSource<MapNearSpotFriendsSection>
    private let nearSpotFriendsTitleLabel = UILabel()
    private let nearSpotFriendsView = UIView()

    private func flexLayout(isNearbyFriendsEmpty: Bool, isNearSpotFriendsEmpty: Bool) {
        
        self.view.flex.define { flex in
            
            flex.addItem(self.nearbyFriendsTitleLabel).marginLeft(40)
            flex.addItem(self.nearbyFriendsView).marginHorizontal(20).grow(1).justifyContent(.center).define { flex in
                
                if isNearbyFriendsEmpty {
                    let emptyLabel = AppLabel(text: "近くにいる友達はいません")
                    emptyLabel.do {
                        $0.textColor = .gray
                    }
                    
                    flex.addItem(emptyLabel)
                } else {
                    flex.addItem(self.nearbyFiendsCollectionView)
                }
            }
            
            flex.addItem(self.nearSpotFriendsTitleLabel).marginLeft(40).marginTop(10)
            flex.addItem(self.nearSpotFriendsView).marginHorizontal(20).marginBottom(10).grow(1).justifyContent(.center).define { flex in
                
                if isNearSpotFriendsEmpty {
                    let emptyLabel = AppLabel(text: "場所を登録しましょう")
                    emptyLabel.do {
                        $0.textColor = .gray
                    }
                    
                    flex.addItem(emptyLabel)
                } else {
                    flex.addItem(self.nearSpotFriendsCollectionView)
                }
            }
        }
    }
}
