//
//  RestaurantSearchResponse.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import ObjectMapper

/// レストラン検索結果
struct RestaurantSearchResponse: Mappable {
    
    var totalHitCount = ""
    var hitPerPage = ""
    var pageOffset = ""
    var restaurants: [Restaurant] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        totalHitCount <- map["total_hit_count"]
        hitPerPage <- map["hit_per_page"]
        pageOffset <- map["page_offset"]
        restaurants <- map["rest"]
    }
}

struct Restaurant: Mappable {
    
    var access: Access?
    var address = ""
    var budget = ""
    var imageUrl: ImageUrl?
    var name = ""
    var tel = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        access <- map["access"]
        address <- map["address"]
        budget <- map["budget"]
        imageUrl <- map["image_url"]
        name <- map["name"]
        tel <- map["tel"]
    }
}

struct ImageUrl: Mappable {
    
    var shopImage = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        shopImage <- map["shop_image1"]
    }
}

struct Access: Mappable {
    
    var station = ""
    var walk = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        station <- map["station"]
        walk <- map["walk"]
    }
}
