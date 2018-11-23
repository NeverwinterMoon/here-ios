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
        
        
        super.init(endpointClosure: <#T##(TargetTypeWrapper) -> Endpoint#>,
                   requestClosure: <#T##(Endpoint, @escaping (Result<URLRequest, MoyaError>) -> Void) -> Void#>,
                   stubClosure: <#T##(TargetTypeWrapper) -> StubBehavior#>,
                   callbackQueue: <#T##DispatchQueue?#>,
                   manager: <#T##Manager#>,
                   plugins: <#T##[PluginType]#>,
                   trackInflights: <#T##Bool#>
        )
    }
}
