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

final class FirebaseStorageUploader {
    
//    let storageRef: StorageReference
//    static let storageRef = Storage.storage().reference()
    
//    init(bucketURL: String) {
//        self.storageRef = Storage.storage(url: "gs://\(bucketURL)").reference()
//    }
    
    public static func uploadFile(_ data: Data, filePath: String, ext: Ext) -> Single<Void> {
        
        return Single.create(subscribe: { observer -> Disposable in
            
            let path = filePath + ext.rawValue
            let fileRef = Storage.storage().reference().child(path)
            print("--------------")
            print(Storage.storage().reference())
            print(fileRef)
            print("--------------")
            fileRef.putData(data, metadata: nil) { (_, error) in
                if let error = error {
                    observer(.error(error))
                    let nserror = error as NSError
                    print(nserror.domain)
                    assertionFailure("\(nserror.code)")
                    return
                }
                observer(.success(()))
            }.enqueue()
            return Disposables.create()
        })
    }
}

public enum Ext: String {
    case jpeg = ".jpg"
    case png = ".png"
}