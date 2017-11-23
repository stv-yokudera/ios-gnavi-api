//
//  RestaurantSearchAPI.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation
import ObjectMapper

/// レストラン検索APIステータス
///
/// - loading: ロード中
/// - loaded: ロード完了
/// - offline: オフライン
/// - error: エラー
enum RestaurantSearchStatus {
    case loadingThen
    case loadedThen(restArray: [Rest])
    case offlineThen
    case errorThen
}

/// レストラン検索APIの結果を通知するプロトコル
protocol RestaurantSearchLoadable: class {
    func searchResult(result: RestaurantSearchStatus)
}

final class RestaurantSearchAPI {

    weak var loadable: RestaurantSearchLoadable?

    private var isLoading = false
    private var requestedCount = 0
    private var totalCount = 1

    func load(areaCode: String, offsetPage: Int = 1) {

        // 通信状況判定
        if !APIClient.isReachable() {
            // ステータスに「オフライン」を設定
            self.loadable?.searchResult(result: .offlineThen)
            return
        }

        // ステータスに「ロード中」を設定
        self.loadable?.searchResult(result: .loadingThen)

        let parameters = RestaurantSearchParamsBuilder.build(areaCode: areaCode, offsetPage: offsetPage)
        let router = Router.restSearchAPI(parameters)
        APIClient.request(router: router) { [weak self] response in

            switch response {
            case .success(let result):

                if let searchResponse = Mapper<RestaurantSearchResponse>().map(JSONObject: result) {

                    // トータルカウントを更新
                    if let total = Int(searchResponse.totalHitCount) {
                        self?.updateTotal(total: total)
                    }

                    // カウントを追加
                    self?.incrementRequestedCount()

                    let restArray = searchResponse.rest

                    // ステータスに「ロード完了」を設定
                    self?.loadable?.searchResult(result: .loadedThen(restArray: restArray))
                }

            case .failure(let error):

                print("error_code: \((error as NSError).code)")
                print("error_description: \((error as NSError).description)")
                // ステータスに「エラー」を設定
                self?.loadable?.searchResult(result: .errorThen)
            }
        }
    }
}

// MARK: - APIリクエスト管理
extension RestaurantSearchAPI {

    // MARK: - リクエストカウント管理

    private func incrementRequestedCount() {
        requestedCount += 1
    }

    private func updateTotal(total: Int) {
        totalCount = total
    }

    func current() -> Int {
        return requestedCount
    }

    func total() -> Int {
        return totalCount
    }

    func hasMoreRequest() -> Bool {
        return totalCount > requestedCount * RestaurantSearchParamsBuilder.perPage
    }

    // MARK: - リクエスト可否判定

    func waiting() -> Bool {
        return isLoading
    }
}
