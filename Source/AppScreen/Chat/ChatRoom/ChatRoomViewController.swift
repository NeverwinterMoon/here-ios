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
        
        self.presenter.userId
            .drive(onNext: { [unowned self] in
                self.userId = $0
            })
            .disposed(by: self.disposeBag)
        
        self.presenter.userDisplayName
            .drive(onNext: { [unowned self] in
                self.userDisplayName = $0
            })
            .disposed(by: self.disposeBag)

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
        return Sender(id: self.userId, displayName: self.userDisplayName)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
    
    // MARK: - MessageLayoutDelegate
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 80
    }
    
    // MARK: - Private
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    private var userDisplayName = ""
    private var userId = ""
    private let disposeBag = DisposeBag()
    
    private func flexLayout() {
    }
    
    private func insertNewMessage(_ message: Message) {
        
        guard !self.messages.contains(where: { $0.messageId == message.messageId }) else {
            return
        }
        
        self.messages.append(message)
        self.messages.sort(by: { $0.sentDate < $1.sentDate })
        
        let isLatestMessage = self.messages.firstIndex(where: { $0.messageId == message.messageId }) == (self.messages.count - 1)

        self.messagesCollectionView.reloadData()
        
        if self.messagesCollectionView.bounds.height > self.view.bounds.height && isLatestMessage {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }

}
