//
//  RestaurantSearchResponse.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import ObjectMapper

struct RestaurantSearchResponse: Mappable {

    var totalHitCount = ""
    var hitPerPage = ""
    var pageOffset = ""
    var rest: [Rest] = []

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        totalHitCount <- map["total_hit_count"]
        hitPerPage <- map["hit_per_page"]
        pageOffset <- map["page_offset"]
        rest <- map["rest"]
    }
}

struct Rest: Mappable {
    
    var station = ""
    var walk = ""
    var address = ""
    var budget = ""
    var imageUrl = ""
    var name = ""
    var tel = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        station <- map["access.station"]
        walk <- map["access.walk"]
        address <- map["address"]
        budget <- map["budget"]
        imageUrl <- map["image_url.shop_image1"]
        name <- map["name"]
        tel <- map["tel"]
    }
}
