//
//  DummyResponse.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

final class DummyResponse: NSObject {
    
    /// レストラン検索APIのダミーレスポンス
    func restaurantSearchApiJSONString() -> String {
        let testBundle = Bundle(for: type(of: self))
        let jsonPath = testBundle.path(forResource: "rest", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: jsonPath!)

        return String(data: fileHandle!.readDataToEndOfFile(), encoding: .utf8)!
    }
}
