//
//  FirebaseStorageUploader.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import RxCocoa
import RxSwift

public final class FirebaseStorageManager {
    
    private static let storageRef = Storage.storage().reference()
    
    public static func uploadFile(_ data: Data, userId: String, fileName: String, ext: Ext) -> Single<Void> {
        
        return Single.create(subscribe: { observer -> Disposable in
            
            let path = "users/\(userId)/profile_image/\(fileName)" + ext.rawValue
            let fileRef = storageRef.child(path)
            fileRef.putData(data, metadata: nil) { (_, error) in
                if let error = error {
                    observer(.error(error))
                    let nserror = error as NSError
                    assertionFailure("\(nserror.code)")
                    return
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    public static func downloadFile(filePath: String) -> Single<Data?> {
        
        return Single.create(subscribe: { observer -> Disposable in
            
            storageRef.child(filePath).getData(maxSize: 1024*1024) { (data, error) in
                if let error = error {
                    observer(.error(error))
                    return
                } else {
                    observer(.success(data))
                }
            }
            return Disposables.create()
        })
    }
}

public enum Ext: String {
    case jpeg = ".jpg"
    case png = ".png"
}
