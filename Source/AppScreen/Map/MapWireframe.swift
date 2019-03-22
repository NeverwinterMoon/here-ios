//
//  MapWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class MapWireframe: AppWireframe, MapWireframeInterface {
    
    func createWatchingPlace() {
        
        guard let navigationController = self.navigationControllerOnSwitch(tabIndex: .profile) else {
            return
        }
        
//        let viewControllers = navigationController.viewControllers
//        if (viewControllers.last as? SearchWatchingPlaceViewController) == nil
//            || (viewControllers.last as? WatchingPlacesViewController) == nil {
//            let watchingPlacesViewController = WatchingPlacesViewController()
//            let watchingPlacesWireframe = WatchingPlacesWireframe(navigationController: navigationController)
//            let watchingPlacesPresenter = WatchingPlacesPresenter(view: watchingPlacesViewController, interactor: ProfileInteractor.shared, wireframe: watchingPlacesWireframe)
//            watchingPlacesViewController.presenter = watchingPlacesPresenter
//            navigationController.pushViewController(watchingPlacesViewController, animated: true)
//        }

        if let _ = (navigationController.viewControllers.last as? SearchWatchingPlaceViewController) {
            return
        }
        
        let controller = SearchWatchingPlaceViewController()
        let wireframe = SearchWatchingPlaceWireframe(navigationController: navigationController)
        let presenter = SearchWatchingPlacePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
}
