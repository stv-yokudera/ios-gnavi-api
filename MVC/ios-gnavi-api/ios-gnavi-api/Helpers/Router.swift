//
//  Router.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    /// ぐるなびAPIベースURL
    static let baseURLString = Constants.gnaviBaseUrl

    /// レストラン検索API
    case restSearchAPI([String: Any])

    func asURLRequest() throws -> URLRequest {

        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {

            switch self {
            case .restSearchAPI(let params):
                return (.get, Constants.restSearchAPIPath, params)
            }
        }()

        let url: URL! = URL(string: Router.baseURLString)
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
