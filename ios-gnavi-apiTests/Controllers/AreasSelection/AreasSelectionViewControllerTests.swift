//
//  AreasSelectionViewControllerTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class AreasSelectionViewControllerTests: XCTestCase {

    var areasSelectionVC: AreasSelectionViewController!
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "AreasSelectionViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AreasSelectionViewController")
            as? AreasSelectionViewController else {
                XCTFail("AreasSelectionViewControllerのインスタンス生成失敗")
                return
        }
        areasSelectionVC = vc
        areasSelectionVC.loadView()
        areasSelectionVC.viewDidLoad()
    }

    func testUITableViewDelegate() {
        XCTAssertNotNil(areasSelectionVC.tableView.delegate)
    }

    func testUITableViewDataSource() {
        XCTAssertNotNil(areasSelectionVC.tableView.dataSource)
    }
}
