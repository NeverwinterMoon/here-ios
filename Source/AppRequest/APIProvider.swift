//
//  APIProvider.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/23.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public struct TargetTypeWrapper: TargetType {
    
    init<T: AppTargetType>(target: T) {
        
        self.baseURL = target.baseURL
        self.path = target.path
        self.method = target.method
        self.sampleData = target.sampleData
        self.task = target.task
        self.headers = target.headers
    }
    
    public let baseURL: URL
    public let path: String
    public let method: Moya.Method
    public let sampleData: Data
    public let task: Task
    public let headers: [String : String]?
}

public class APIProvider: MoyaProvider<TargetTypeWrapper> {
    
    public static let shared = APIProvider()
    
    private init() {
        
        let endPointClosure: EndpointClosure = { target in
            
            return MoyaProvider.defaultEndpointMapping(for: target)
        }
        
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure = { change, _ in
            
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        let requestClosure: RequestClosure = { endPoint, closure in
            
            return MoyaProvider<TargetTypeWrapper>.defaultRequestMapping(for: endPoint, closure: closure)
        }
        
        var plugins: [PluginType] = []
        plugins.append(NetworkActivityPlugin(networkActivityClosure: networkActivityClosure))
        
        super.init(endpointClosure: endPointClosure,
                   requestClosure: requestClosure,
                   stubClosure: MoyaProvider.neverStub,
                   callbackQueue: DispatchQueue.main,
                   manager: .default,
                   plugins: plugins,
                   trackInflights: false)
    }
}
