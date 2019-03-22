//
//  WatchingPlacesWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class WatchingPlacesWireframe: AppWireframe, WatchingPlacesWireframeInterface {
    
    func pushCreateWatchingPlace() {
        let controller = SearchWatchingPlaceViewController()
        let wireframe = SearchWatchingPlaceWireframe(navigationController: self.navigationController)
        let presenter = SearchWatchingPlacePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
