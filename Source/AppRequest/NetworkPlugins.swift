//
//  NetworkPlugins.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/12/10.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import Moya
import Result

final class AppNetworkLoggerPlugin: PluginType {
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        print("\n --------- 🚀 NETWORK 🚀 --------- \n")
        switch result {
        case .success(let response):
            self.outputItems(self.logNetworkResponse(response.response, data: response.data, target: target))
        case .failure:
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
//
//final class AppAlertPlugin: PluginType {
//    
//    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
//        
//        guard case Result.failure(_) = result else { return }
//        
//        let data = result.error
//        let error = try JSONDecoder().decode(APIError.self, from: data)
//        let alertViewController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
//        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        
//        //and present using the view controller we created at initialization
//        viewController.present(viewControllerToPresent: alertViewController, animated: true)
//    }
//}
