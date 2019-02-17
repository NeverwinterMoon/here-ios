//
//  ChatRoomViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FlexLayout
import RxCocoa
import RxSwift

final class ChatRoomViewController: UIViewController, ChatRoomViewInterface {
    
    var presenter: ChatRoomPresenterInterface!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.presenter.userDisplayName
            .drive(onNext: { [unowned self] in
                self.title = $0
            })
            .disposed(by: self.disposeBag)

        self.flexLayout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
        self.view.flex.paddingTop(self.view.safeAreaInsets.top)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
    
    private func flexLayout() {
    }
}
