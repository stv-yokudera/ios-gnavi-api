//
//  APIClient.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/14.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Alamofire
import UIKit

enum Result {
    case success(Any)
    case failure(Error)
}

final class APIClient {
    
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
    
    /// API Request
    static func request(router: Router,
                        completionHandler: @escaping (Result) -> Void = { _ in }) {
        
        Alamofire.request(router).responseJSON { response in
            
            let statusCode = response.response?.statusCode
            print("http status code: \(String(describing: statusCode))")
            
            switch response.result {
                
            case .success(let value):
                completionHandler(Result.success(value))
                return
                
            case .failure:
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
}
