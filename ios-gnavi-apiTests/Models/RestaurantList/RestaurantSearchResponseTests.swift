//
//  RestaurantSearchResponseTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import ObjectMapper
import XCTest

final class RestaurantSearchResponseTests: XCTestCase {

    func testMapping() {

        let dummy = DummyResponse().restaurantSearchApiJSONString()
        guard let searchResponse = Mapper<RestaurantSearchResponse>().map(JSONString: dummy) else {
            XCTFail("Mapping failure.")
            return
        }

        XCTAssertEqual(searchResponse.totalHitCount, "3813")
        XCTAssertEqual(searchResponse.hitPerPage, "50")
        XCTAssertEqual(searchResponse.pageOffset, "1")

        guard let firstRest = searchResponse.rest.first else {
            XCTFail("rest is nil.")
            return
        }
        XCTAssertEqual(firstRest.station, "銀座駅")
        XCTAssertEqual(firstRest.walk, "5")
        XCTAssertEqual(firstRest.address, "〒104-0061 東京都中央区銀座7-2-20 パシフィックギンザビルB1")
        XCTAssertEqual(firstRest.budget, "4320")
        XCTAssertEqual(firstRest.imageUrl, "https://uds.gnst.jp/rest/img/9km8b21e0000/t_0077.jpg")
        XCTAssertEqual(firstRest.name, "アンジェロ ")
        XCTAssertEqual(firstRest.tel, "050-3477-8936")
    }
}
