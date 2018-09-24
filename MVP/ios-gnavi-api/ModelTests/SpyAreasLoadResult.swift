//
//  SpyAreasLoadResult.swift
//  ios-gnavi-apiTests
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import XCTest
@testable import Model

final class SpyAreasLoadResult: AreasLoadResult {
    
    var asyncExpectation: XCTestExpectation?
    
    // MARK: - AreasLoadResult
    
    func loadSucceeded(areas: [Area]) {
        
        guard let expectation = asyncExpectation else {
            XCTFail("Delegateが正しく設定されていない")
            return
        }
        
        // Verify
        verifyDataCount(areas: areas)
        verifyFirstArea(areas: areas)
        
        expectation.fulfill()
    }
    
    func loadFailed(errorMessage: String) {
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
