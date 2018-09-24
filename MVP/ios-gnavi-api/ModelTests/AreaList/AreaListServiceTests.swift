//
//  AreaListServiceTests.swift
//  ModelTests
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import XCTest
@testable import Model

final class AreaListServiceTests: XCTestCase {

    let service = AreaListService()
    let delegate = SpyAreasLoadResult()

    override func setUp() {
        super.setUp()
        service.delegate = delegate;
    }

    override func tearDown() {
        service.delegate = nil
        super.tearDown()
    }

    /// リソースのJSONファイルから東京都のエリア情報をロードするテスト
    func testLoad() {

        // Setup
        let expectation = self.expectation(description: "JSONファイルの読み込み、デコードが成功すること")
        delegate.asyncExpectation = expectation

        // Exercise
        service.load(prefName: "東京都")

        waitForExpectations(timeout: 0.3) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
        }
    }
}
