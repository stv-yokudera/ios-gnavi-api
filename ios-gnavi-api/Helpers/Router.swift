//
//  Router.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/14.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    /// ぐるなびAPIベースURL
    static let baseURLString = "https://api.gnavi.co.jp/"
    
    /// レストラン検索API
    case restSearchAPI([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .restSearchAPI(let params):
                return (.get, "RestSearchAPI/20150630/", params)
            }
        }()
        
        if let url = URL(string: Router.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("url is nil.")
        }
    }
}
