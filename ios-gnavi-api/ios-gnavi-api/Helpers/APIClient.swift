//
//  APIClient.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Alamofire

protocol APIRequester {
    
    /// リクエストを実行する
    func executeAPI()
    
    /// リクエストパラメータを生成する
    ///
    /// - Returns: リクエストパラメータ
    func buildParameters() -> [String: Any]
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
    static func request(router: Router, completionHandler: @escaping (Result<Data>) -> Void = { _ in }) {
        
        Alamofire.request(router).validate(statusCode: 200 ..< 300).responseData { response in
            
            switch response.result {
                
            case .success(let value):
                completionHandler(Result.success(value))
                return
            case .failure(let error):
                completionHandler(Result.failure(error))
                return
            }
        }
    }
}
