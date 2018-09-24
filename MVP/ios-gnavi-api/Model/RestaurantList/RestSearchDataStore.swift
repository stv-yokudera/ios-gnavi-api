//
//  RestSearchDataStore.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

/// レストラン検索結果を通知するプロトコル
public protocol RestSearchResult: class {
    func fetchSucceeded(restaurants: [Restaurant])
    func fetchFailed(errorMessage: String)
}

/// レストラン検索APIリクエストクラス
final public class RestSearchDataStore {

    public weak var delegate: RestSearchResult?
    public var isLoading = false

    public init(areaCode: String) {
        self.areaCode = areaCode
    }

    private let perPage = 50
    private var areaCode: String
    private var requestCount = 0
    private var totalCount = 1
}

extension RestSearchDataStore: APIRequester {

    public func executeAPI() {

        if isLoading {
            return
        }

        // 通信状況確認
        if !APIClient.isReachable() {
            delegate?.fetchFailed(errorMessage: Constants.offlineMessage)
            return
        }

        isLoading = true

        incrementRequestCount()
        print("offsetPage: \(current())")

        let parameters = buildParameters()
        let router = Router.restSearchAPI(parameters)

        APIClient.request(router: router) { result in

            switch result {
            case .success(let data):

                do {
                    let jsonDecoder = JSONDecoder()
                    let searchResponse = try jsonDecoder.decode(RestaurantSearchResponse.self, from: data)

                    // トータルカウントを更新
                    self.updateTotal(total: searchResponse.totalHitCount)
                    self.delegate?.fetchSucceeded(restaurants: searchResponse.restaurants)
                } catch {
                    print(error)
                    self.delegate?.fetchFailed(errorMessage: Constants.fetchFailedMessage)
                }

            case .failure(let error):

                print(error.ns)
                if error.isOffline || error.isTimeout {
                    self.delegate?.fetchFailed(errorMessage: Constants.offlineMessage)
                    return
                }
                self.delegate?.fetchFailed(errorMessage: Constants.fetchFailedMessage)
            }
        }
    }

    func buildParameters() -> [String: Any] {

        return ["keyid": "24b0fbbe0898310f404c2b6838f22e84",
                "areacode_l": areaCode,
                "hit_per_page": perPage.description,
                "offset_page": current().description
        ]
    }
}

// MARK: - APIリクエストカウント管理
extension RestSearchDataStore {

    public func total() -> Int {
        return totalCount
    }

    public func hasMoreRequest() -> Bool {
        return totalCount > requestCount * perPage
    }
    
    private func updateTotal(total: Int) {
        totalCount = total
    }

    private func current() -> Int {
        return requestCount
    }

    private func incrementRequestCount() {
        requestCount += 1
    }

    private func decrementRequestCount() {
        requestCount -= 1
    }
}
