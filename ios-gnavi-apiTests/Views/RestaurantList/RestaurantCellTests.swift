//
//  RestaurantCellTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import ObjectMapper
import XCTest

final class RestaurantCellTests: XCTestCase {

    let dataSource = FakeDataSource()
    var tableView: UITableView!
    var cell: RestaurantCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "RestaurantListViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantListViewController")
            as? RestaurantListViewController else {
                XCTFail("RestaurantListViewControllerのインスタンス生成失敗")
                return
        }

        vc.loadView()

        tableView = vc.tableView
        tableView.dataSource = dataSource

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantCell.identifier,
            for: IndexPath(row: 0, section: 0)) as? RestaurantCell else {
                XCTFail("RestaurantCellのインスタンス生成失敗")
                return
        }
        self.cell = cell
    }

    func testRestaurantCellLabels() {

        let dummy = DummyResponse().restaurantSearchApiJSONString()
        guard let searchResponse = Mapper<RestaurantSearchResponse>().map(JSONString: dummy) else {
            XCTFail("Mapping failure.")
            return
        }

        guard let firstRest = searchResponse.rest.first else {
            XCTFail("rest is nil.")
            return
        }

        cell.item = firstRest
        XCTAssertEqual(cell.restaurantNameLabel.text, "アンジェロ ")
        XCTAssertEqual(cell.stationLabel.text, "銀座駅 5分")
        XCTAssertEqual(cell.addressLabel.text, "〒104-0061 東京都中央区銀座7-2-20 パシフィックギンザビルB1")
        XCTAssertEqual(cell.telLabel.text, "050-3477-8936")
        XCTAssertEqual(cell.budgetLabel.text, "¥4,320")
    }
}

extension RestaurantCellTests {

    final class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
