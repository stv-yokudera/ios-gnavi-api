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

public struct Restaurant: Codable {
    
    public var access = Access()
    public var address = ""
    public var budget = 0
    public var imageUrl = ImageUrl()
    public var name = ""
    public var tel = ""

    private enum CodingKeys: String, CodingKey {

        case access = "access"
        case address = "address"
        case budget = "budget"
        case imageUrl = "image_url"
        case name = "name"
        case tel = "tel"
    }
}

public struct ImageUrl: Codable {
    
    public var shopImage = ""

    private enum CodingKeys: String, CodingKey {
        case shopImage = "shop_image1"
    }
}

public struct Access: Codable {
    
    public var station = ""
    public var walk = ""

    private enum CodingKeys: String, CodingKey {
        case station = "station"
        case walk = "walk"
    }
}
