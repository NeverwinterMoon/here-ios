//
//  MapViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppExtensions
import CoreLocation
import FlexLayout
import MapKit

public final class MapViewController: UIViewController, CLLocationManagerDelegate, MapViewInterface {
    
    var presenter: MapPresenter!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
            self.checkLocationAuthorization()
        } else {
            
            // show alert
        }
        
        self.flexLayout()
    }
    
    override public func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last!
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.mapView.setRegion(region, animated: true)
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            self.mapView.showsUserLocation = true
        case .denied, .notDetermined, .restricted:
//            show some alert, but get the locations of friends
            break
        }
    }

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private func flexLayout() {

        self.view.flex.define { flex in
            
            flex.addItem().grow(1).define { flex in
                flex.addItem(self.mapView).grow(1)
            }
        }
    }
}
