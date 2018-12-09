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
import Result

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
        plugins.append(AppNetworkLoggerPlugin())
        
        super.init(endpointClosure: endPointClosure,
                   requestClosure: requestClosure,
                   stubClosure: MoyaProvider.neverStub,
                   callbackQueue: DispatchQueue.main,
                   manager: .default,
                   plugins: plugins,
                   trackInflights: false)
    }
}

final class AppNetworkLoggerPlugin: PluginType {
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("\n --------- 🚀 NETWORK 🚀 --------- \n")
        switch result {
        case .success(let response):
            self.outputItems(self.logNetworkResponse(response.response, data: response.data, target: target))
        case .failure(let error):
            self.outputItems(self.logNetworkResponse(nil, data: nil, target: target))
        }
        print("\n --------- 🚀 END 🚀 --------- \n")
    }
    
    // MARK: - Private
    private let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    private let dateFormatter = DateFormatter()

    private var date: String {
        self.dateFormatter.dateFormat = self.dateFormatString
        self.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return self.dateFormatter.string(from: Date())
    }
    
    private func outputItems(_ items: [String]) {
        items.forEach { print($0) }
    }
    
    private func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }
    
    private func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
            return [self.format("Moya_Logger", date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }
        
        var output = [String]()
        
        output += [self.format("Moya_Logger", date: date, identifier: "Response", message: response.description)]
        
        if let data = data, let stringData = String(data: data, encoding: String.Encoding.utf8) {
            output += [stringData]
        }

        return output
    }
}
