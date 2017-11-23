//
//  GAreaLarge.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/14.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation

struct GAreaLarge: Codable {
    
    var gareaLarge: [Area]?
    
    private enum CodingKeys: String, CodingKey {
        case gareaLarge = "garea_large"
    }
}

struct Area: Codable {
    
    var areacodeL = ""
    var areanameL = ""
    var pref: Pref?
    
    private enum CodingKeys: String, CodingKey {
        case areacodeL = "areacode_l"
        case areanameL = "areaname_l"
        case pref = "pref"
    }
}

struct Pref: Codable {
    
    var prefCode = ""
    var prefName = ""
    
    private enum CodingKeys: String, CodingKey {
        case prefCode = "pref_code"
        case prefName = "pref_name"
    }
}
