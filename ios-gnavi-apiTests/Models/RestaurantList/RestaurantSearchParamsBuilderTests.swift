//
//  RestaurantSearchParamsBuilderTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class RestaurantSearchParamsBuilderTests: XCTestCase {

    /// レストラン検索APIのリクエストパラメータを生成する
    func testBuildWithTagsAtPage() {
        
        let parameters = RestaurantSearchParamsBuilder.build(areaCode: "AREAL2101",
                                                             offsetPage: 1)
        XCTAssertEqual(parameters["keyid"], "d0fafaeeb5c0b721e5a20b628725900f")
        XCTAssertEqual(parameters["areacode_l"], "AREAL2101")
        XCTAssertEqual(parameters["format"], "json")
        XCTAssertEqual(parameters["hit_per_page"], "50")
        XCTAssertEqual(parameters["offset_page"], "1")
    }
    
}
