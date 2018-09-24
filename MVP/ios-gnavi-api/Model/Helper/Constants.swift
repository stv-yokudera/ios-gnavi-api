//
//  Constants.swift
//  Model
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

struct Constants {

    private init() {}

    // MARK: - AreaList
    static let loadFailedMessage = "エリア情報の取得に失敗しました。"
    static let areaJsonFileName = "area.json"

    // MARK: - RestaurantList
    static let offlineMessage = "通信環境の良い場所で再度お試しください。"
    static let fetchFailedMessage = "レストラン情報の取得に失敗しました。"
    
    // MARK: - API
    static let gnaviBaseUrl = "https://api.gnavi.co.jp/"
    static let restSearchAPIPath = "RestSearchAPI/v3/"
}
