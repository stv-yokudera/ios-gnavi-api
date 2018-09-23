//
//  RestaurantSearchResponse.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

/// レストラン検索結果
struct RestaurantSearchResponse: Codable {
    
    var totalHitCount = 0
    var restaurants: [Restaurant] = []

    private enum CodingKeys: String, CodingKey {
        case totalHitCount = "total_hit_count"
        case restaurants = "rest"
    }
}

struct Restaurant: Codable {
    
    var access = Access()
    var address = ""
    var budget = 0
    var imageUrl = ImageUrl()
    var name = ""
    var tel = ""

    private enum CodingKeys: String, CodingKey {

        case access = "access"
        case address = "address"
        case budget = "budget"
        case imageUrl = "image_url"
        case name = "name"
        case tel = "tel"
    }
}

struct ImageUrl: Codable {
    
    var shopImage = ""

    private enum CodingKeys: String, CodingKey {
        case shopImage = "shop_image1"
    }
}

struct Access: Codable {
    
    var station = ""
    var walk = ""

    private enum CodingKeys: String, CodingKey {
        case station = "station"
        case walk = "walk"
    }
}
