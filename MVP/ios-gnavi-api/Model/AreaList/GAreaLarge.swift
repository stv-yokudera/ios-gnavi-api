//
//  GAreaLarge.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

/// エリア情報の第一階層
struct GAreaLarge: Codable {
    
    var gareaLarge: [Area]?
}

/// エリア情報の第二階層
public struct Area: Codable {
    
    public var areacodeL = ""
    public var areanameL = ""
    var pref: Pref?
}

/// エリア情報の第三階層
struct Pref: Codable {
    
    var prefCode = ""
    var prefName = ""
}
