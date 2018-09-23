//
//  ios_gnavi_apiUITests.swift
//  ios-gnavi-apiUITests
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import XCTest

final class ios_gnavi_apiUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testAreaListViewController() {
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait

        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["飯田橋・四ツ谷・神楽坂"].swipeUp()
        tablesQuery.staticTexts["お台場・豊洲・湾岸"].swipeDown()
    }
}
