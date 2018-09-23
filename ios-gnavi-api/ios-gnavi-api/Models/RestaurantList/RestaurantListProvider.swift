//
//  RestaurantListProvider.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

final class RestaurantListProvider: NSObject {
    
    private var restaurants = [Restaurant]()
    
    func add(restaurants: [Restaurant]) {
        self.restaurants.append(contentsOf: restaurants)
    }
}

extension RestaurantListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurantCell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantCell.identifier,
            for: indexPath
        ) as! RestaurantCell

        setRestaurantInfo(restaurantInfo: restaurants[indexPath.row], cell: restaurantCell)
        return restaurantCell
    }
}

private extension RestaurantListProvider {

    func setRestaurantInfo(restaurantInfo: Restaurant?, cell: RestaurantCell) {

        guard let restaurantInfo = restaurantInfo else {
            return
        }

        if let shopImageUrl = URL(string: restaurantInfo.imageUrl.shopImage) {
            cell.restaurantImageView.kf.setImage(with: shopImageUrl)
        }

        cell.restaurantNameLabel.text = restaurantInfo.name
        cell.stationLabel.text = String(format: "walkingTimeFromStation".localized(),
                                        restaurantInfo.access.station,
                                        restaurantInfo.access.walk)
        cell.addressLabel.text = restaurantInfo.address
        cell.telLabel.text = restaurantInfo.tel

        cell.budgetLabel.text = String(format: "budget".localized(), restaurantInfo.budget.decimalString)
    }
}
