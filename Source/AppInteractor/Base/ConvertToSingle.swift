//
//  ConvertToSingle.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/25.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import RxSwift

extension AppTargetType {
    
    public func asSingle() -> Single<ElementType> {
        
        return self.primitiveSequence.asObservable().asSingle().do(onError: { (error) in
            
            if let apiError = error as? APIError, let currentController = UIApplication.shared.keyWindow?.rootViewController {
                let alertController = UIAlertController(title: "エラー", message: apiError.message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                currentController.present(alertController, animated: true, completion: nil)
            }
        })
    }
}
