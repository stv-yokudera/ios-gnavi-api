//
//  AreasLoaderTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class AreasLoaderTests: XCTestCase {

    let areasLoader = AreasLoader()
    let loadable = SpyAreasLoadable()

    override func setUp() {
        super.setUp()
        areasLoader.loadable = loadable
    }

    override func tearDown() {
        areasLoader.loadable = nil
        super.tearDown()
    }

    /// リソースのJSONファイルから東京都のエリア情報をロードするテスト
    func testLoad() {

        let expectation = self.expectation(description: "jsonのparseが成功すること")
        loadable.asyncExpectation = expectation

        areasLoader.load(prefName: "東京都")

        waitForExpectations(timeout: 2.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsエラー: \(error)")
            }
        }
    }
    
}
