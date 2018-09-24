//
//  ViewControllerBuilder.swift
//  View
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit
import Model

final class ViewControllerBuilder {

    /// エリア選択画面
    static func buildAreaList(service: AreaListService) -> AreaListViewController {
        
        let vcName = AreaListViewController.className
        let vc = UIStoryboard.viewController(storyboardName: vcName, identifier: vcName) as! AreaListViewController
        vc.areaListPresenter = AreaListPresenter(service: service)
        
        return vc
    }

    /// レストラン一覧画面
    static func buildRestaurantList(area: Area,
                                    restSearchDataStore: RestSearchDataStore) -> RestaurantListViewController {
        
        let vcName = RestaurantListViewController.className
        let vc = UIStoryboard.viewController(storyboardName: vcName,
                                             identifier: vcName) as! RestaurantListViewController
        vc.restaurantListPresenter = RestaurantListPresenter(area: area, restSearchDataStore: restSearchDataStore)
        
        return vc
    }
}
