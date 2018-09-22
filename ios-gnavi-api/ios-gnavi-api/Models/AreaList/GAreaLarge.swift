//
//  GAreaLarge.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

struct GAreaLarge: Codable {
    
    var gareaLarge: [Area]?
}

struct Area: Codable {
    
    var areacodeL = ""
    var areanameL = ""
    var pref: Pref?
}

struct Pref: Codable {
    
    var prefCode = ""
    var prefName = ""
}
