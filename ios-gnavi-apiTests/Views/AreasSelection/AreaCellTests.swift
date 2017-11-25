//
//  AreaCellTests.swift
//  ios-gnavi-apiTests
//
//  Created by OkuderaYuki on 2017/11/25.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

@testable import ios_gnavi_api
import XCTest

final class AreaCellTests: XCTestCase {

    let dummyAreanameL = "銀座・有楽町・築地"
    let dataSource = FakeDataSource()
    var tableView: UITableView!
    var cell: UITableViewCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "AreasSelectionViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AreasSelectionViewController")
            as? AreasSelectionViewController else {
                XCTFail("AreasSelectionViewControllerのインスタンス生成失敗")
                return
        }

        vc.loadView()

        tableView = vc.tableView
        tableView.dataSource = dataSource

        let cellIdentifier = "AreaCell"
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = dummyAreanameL
    }

    func testAreaCellText() {
        XCTAssertEqual(cell.textLabel?.text, "銀座・有楽町・築地")
    }
}

extension AreaCellTests {

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
