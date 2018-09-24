//
//  RestaurantListView.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

protocol RestaurantListView: BaseView {

    func showIndicator()
    func hideIndicator()
    func updateTitle(newTitle: String)
    func reloadRestaurantList()
}

