//
//  JSONFileReaderTests.swift
//  ios-gnavi-apiTests
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import XCTest
@testable import Model

final class JSONFileReaderTests: XCTestCase {

    /// area.jsonを読み込む処理をテスト
    func testRead() {

        do {
            // Exercise
            guard let jsonData = try JSONFileReader.read(fileName: Constants.areaJsonFileName) else {
                XCTFail("jsonData is nil.")
                return
            }

            // Verify
            verifyReadData(data: jsonData)

        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func verifyReadData(data: Data) {
        XCTAssertEqual(data.count, 64637)
    }

    /// main bundleに存在しないファイル名を指定した場合にnilが返却されることをテスト
    func testReadWhenFileNotFound() {

        let fileName = "notFound.json"
        do {
            // Exercise
            let jsonData = try JSONFileReader.read(fileName: fileName)

            // Verify
            if jsonData != nil {
                XCTFail("jsonData is not nil.")
            }

        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
