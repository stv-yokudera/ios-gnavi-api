//
//  SpyRestaurantSearchLoadable.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class SpyRestaurantSearchLoadable: RestaurantSearchLoadable {

    var status: RestaurantSearchStatus?
    var asyncExpectation: XCTestExpectation?

    func searchResult(result: RestaurantSearchStatus) {

        guard let expectation = asyncExpectation else {
            XCTFail("Delegateが正しく設定されていない")
            return
        }

        self.status = result
        expectation.fulfill()
    }
}
