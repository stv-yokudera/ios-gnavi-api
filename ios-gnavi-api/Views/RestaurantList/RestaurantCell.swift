//
//  RestaurantCell.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Kingfisher
import UIKit

final class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    var item: Rest? {

        didSet {
            setItem(newItem: item)
        }
    }

    private func setItem(newItem: Rest?) {

        if let item = self.item {

            let imageUrl = URL(string: item.imageUrl)
            restaurantImageView.kf.setImage(with: imageUrl)

            restaurantNameLabel.text = item.name
            stationLabel.text = String(format: "WALKING_TIME_FROM_STATION".localized(),
                                       item.station,
                                       item.walk)
            addressLabel.text = item.address
            telLabel.text = item.tel

            if let budget = Int(item.budget) {
                budgetLabel.text = String(format: "BUDGET".localized(), budget.decimalString)
            }
        }
    }
}
