//
//  RestaurantListProvider.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/18.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

final class RestaurantListProvider: NSObject {

    private var restArray = [Rest]()

    /// レストラン情報の配列を設定する
    ///
    /// - Parameter restArray: レストラン情報の配列
    func add(restArray: [Rest]) {
        self.restArray.append(contentsOf: restArray)
        print("count: \(self.restArray.count)")
    }
}

// MARK: - UITableViewDataSource
extension RestaurantListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantCell.identifier,
            for: indexPath) as? RestaurantCell else {

                return UITableViewCell()
        }

        cell.restaurantImageView.image = nil
        cell.item = restArray[indexPath.row]
        return cell
    }
}
