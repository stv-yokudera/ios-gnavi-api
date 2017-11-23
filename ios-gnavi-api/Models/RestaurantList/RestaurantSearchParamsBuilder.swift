//
//  RestaurantSearchParamsBuilder.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation

final class RestaurantSearchParamsBuilder {

    static let perPage = 50

    /// レストラン検索APIのリクエストパラメータを生成する
    ///
    /// - Parameters:
    ///   - areaCode: エリアコード
    ///   - offsetPage: 開始位置
    /// - Returns: リクエストパラメータ
    static func build(areaCode: String, offsetPage: Int = 1) -> [String: String] {

        return ["keyid": "d0fafaeeb5c0b721e5a20b628725900f",
                "areacode_l": areaCode,
                "format": "json",
                "hit_per_page": perPage.description,
                "offset_page": offsetPage.description
        ]
    }
}
