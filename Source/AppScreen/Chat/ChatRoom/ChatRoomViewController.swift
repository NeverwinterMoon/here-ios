//
//  ChatRoomViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FlexLayout
import MessageKit
import RxCocoa
import RxSwift

final class ChatRoomViewController: MessagesViewController, ChatRoomViewInterface, MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {

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
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        
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
    
    // MARK: - MessagesDataSource
    func currentSender() -> Sender {
        return Sender(id: <#T##String#>, displayName: <#T##String#>)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
    
    // MARK: - Private
    private var messages: [MessageType] = []
    private var messageListener: ListenerRegistration?
    private let disposeBag = DisposeBag()
    
    private func flexLayout() {
    }
}
