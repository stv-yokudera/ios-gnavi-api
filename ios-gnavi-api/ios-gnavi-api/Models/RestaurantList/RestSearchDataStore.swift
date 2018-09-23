//
//  RestSearchDataStore.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation
import ObjectMapper

/// レストラン検索結果を通知するプロトコル
protocol RestSearchResult: class {
    func fetchSucceeded(restaurants: [Restaurant])
    func fetchFailed(errorMessage: String)
}

/// レストラン検索APIリクエストクラス
final class RestSearchDataStore {

    private let perPage = 50

    weak var delegate: RestSearchResult?

    var areaCode: String
    var isLoading = false
    
    private var requestCount = 0
    private var totalCount = 1

    init(areaCode: String) {
        self.areaCode = areaCode
    }
}

extension RestSearchDataStore: APIRequester {

    func execute() {

        if isLoading {
            return
        }

        // 通信状況確認
        if !APIClient.isReachable() {
            delegate?.fetchFailed(errorMessage: "offlineMSG".localized())
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

                guard
                    let jsonString = String(data: data, encoding: .utf8),
                    let searchResponse = Mapper<RestaurantSearchResponse>().map(JSONString: jsonString) else {

                        self.delegate?.fetchFailed(errorMessage: "fetchFailedMSG".localized())
                        return
                }

                // トータルカウントを更新
                if let total = Int(searchResponse.totalHitCount) {
                    self.updateTotal(total: total)
                }
                // ステータスに「ロード完了」を設定
                self.delegate?.fetchSucceeded(restaurants: searchResponse.restaurants)

            case .failure(let error):

                print(error.ns)
                if error.isOffline || error.isTimeout {
                    self.delegate?.fetchFailed(errorMessage: "offlineMSG".localized())
                    return
                }
                self.delegate?.fetchFailed(errorMessage: "fetchFailedMSG".localized())
            }
        }
    }

    func buildParameters() -> [String : Any] {

        return ["keyid": "24b0fbbe0898310f404c2b6838f22e84",
                "areacode_l": areaCode,
                "format": "json",
                "hit_per_page": perPage.description,
                "offset_page": current().description
        ]
    }
}

// MARK: - APIリクエスト管理
extension RestSearchDataStore {

    // MARK: - リクエストカウント管理
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

    func total() -> Int {
        return totalCount
    }

    func hasMoreRequest() -> Bool {
        return totalCount > requestCount * perPage
    }
}
