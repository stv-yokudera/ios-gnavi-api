//
//  RestaurantSearchAPITests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class RestaurantSearchAPITests: XCTestCase {

    let restaurantSearchAPI = RestaurantSearchAPI()
    let loadable = SpyRestaurantSearchLoadable()

    override func setUp() {
        super.setUp()
        restaurantSearchAPI.loadable = loadable
    }

    override func tearDown() {
        restaurantSearchAPI.loadable = nil
        super.tearDown()
    }

    /// エリアコードAREAL2101 銀座・有楽町・築地のレストラン情報を検索するテスト
    func testLoadWithAreaCodeAREAL2101() {

        let expectation = self.expectation(description: "データが1件以上返却されること")
        loadable.asyncExpectation = expectation

        restaurantSearchAPI.load(areaCode: "AREAL2101")

        waitForExpectations(timeout: 2.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsエラー: \(error)")
            }

            if let status = self.loadable.status {

                switch status {
                case .loadingThen:
                    XCTAssertTrue(true, "読み込み中")

                case .loadedThen(restArray: let restArray):
                    XCTAssertNotNil(restArray)
                    XCTAssertFalse(restArray.isEmpty)

                case .offlineThen:
                    XCTFail("オフライン")

                case .errorThen:
                    XCTFail("エラー")
                }
            }
        }
    }
}
