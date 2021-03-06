//
//  AlertController.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public struct ActionSheetItem<Type: Equatable> {
    
    public init(title: String, actionType: Type, style: UIAlertAction.Style) {
        self.title = title
        self.actionType = actionType
        self.style = style
    }
    public let title: String
    public let actionType: Type
    public let style: UIAlertAction.Style
}

extension UIViewController {
   public func showActionSheet<Type>(title: String?, message: String? = nil, cancelMessage: String = "キャンセル", actions: [ActionSheetItem<Type>]) -> Observable<Type> {

        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        return actionSheet.addAction(actions: actions, cancelMessage: cancelMessage, cancelAction: nil)
            .do(onSubscribed: { [unowned self] in
                self.present(actionSheet, animated: true, completion: nil)
            })
    }
    public func showActionSheet<Type>(controller: UIAlertController, cancelMessage: String = "キャンセル", actions: [ActionSheetItem<Type>]) -> Observable<Type> {

        return controller.addAction(actions: actions, cancelMessage: cancelMessage, cancelAction: nil)
            .do(onSubscribed: { [unowned self] in
                self.present(controller, animated: true, completion: nil)
            })
    }
}

extension UIAlertController {
    
    public func addAction<Type>(actions: [ActionSheetItem<Type>], cancelMessage: String = "キャンセル", cancelAction: ((UIAlertAction) -> Void)? = nil) -> Observable<Type> {

        return Observable.create { [unowned self] observer in
            actions.map { action in
                UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.actionType)
                    observer.onCompleted()
                }
            }.forEach {
                self.addAction($0)
            }

            self.addAction(UIAlertAction(title: cancelMessage, style: .cancel) {
                cancelAction?($0)
                observer.onCompleted()
            })

            return Disposables.create {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
