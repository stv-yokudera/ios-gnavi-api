//
//  SpyAreasLoadable.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class SpyAreasLoadable: AreasLoadable {
    
    var asyncExpectation: XCTestExpectation?
    
    func loadedThen(areas: [Area]) {
        
        guard let expectation = asyncExpectation else {
            XCTFail("Delegateが正しく設定されていない")
            return
        }

        verifyDataCount(areas: areas)
        verifyFirstArea(areas: areas)

        expectation.fulfill()
    }
    
    func failedThen() {
        XCTFail("JSONの読み込み失敗")
    }

    // MARK: - Verify

    func verifyDataCount(areas: [Area]) {
        XCTAssertEqual(areas.count, 28)
    }

    func verifyFirstArea(areas: [Area]) {

        XCTAssertEqual(areas.first?.areacodeL, "AREAL2101")
        XCTAssertEqual(areas.first?.areanameL, "銀座・有楽町・築地")
        XCTAssertEqual(areas.first?.pref?.prefCode, "PREF13")
        XCTAssertEqual(areas.first?.pref?.prefName, "東京都")
    }
}
