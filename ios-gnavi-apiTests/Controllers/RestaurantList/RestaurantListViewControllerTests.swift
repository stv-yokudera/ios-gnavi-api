//
//  RestaurantListViewControllerTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class RestaurantListViewControllerTests: XCTestCase {

    var restaurantListVC: RestaurantListViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "RestaurantListViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantListViewController")
            as? RestaurantListViewController else {
                XCTFail("RestaurantListViewControllerのインスタンス生成失敗")
                return
        }

        restaurantListVC = vc
        restaurantListVC.loadView()
        restaurantListVC.viewDidLoad()
    }

    func testUITableViewDelegate() {
        XCTAssertNotNil(restaurantListVC.tableView.delegate)
    }

    func testUITableViewDataSource() {
        XCTAssertNotNil(restaurantListVC.tableView.dataSource)
    }
}
