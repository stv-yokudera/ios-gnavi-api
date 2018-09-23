//
//  AreasLoaderTests.swift
//  ios-gnavi-apiTests
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_gnavi_api

final class AreasLoaderTests: XCTestCase {

    let areasLoader = AreasLoader()
    let delegate = SpyAreasLoadResult()

    override func setUp() {
        super.setUp()
        areasLoader.delegate = delegate;
    }

    override func tearDown() {
        areasLoader.delegate = nil
        super.tearDown()
    }

    /// リソースのJSONファイルから東京都のエリア情報をロードするテスト
    func testLoad() {

        // Setup
        let expectation = self.expectation(description: "JSONファイルの読み込み、デコードが成功すること")
        delegate.asyncExpectation = expectation

        // Exercise
        areasLoader.load(prefName: "東京都")

        waitForExpectations(timeout: 0.3) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
        }
    }
}
