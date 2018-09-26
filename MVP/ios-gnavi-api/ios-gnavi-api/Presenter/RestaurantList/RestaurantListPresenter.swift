//
//  RestaurantListPresenter.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Model

final class RestaurantListPresenter: BasePresenter {

    private let area: Area
    private let restSearchDataStore: RestSearchDataStore
    weak private var view: RestaurantListView?
    private(set) var restaurants = [Restaurant]()

    init(area: Area, restSearchDataStore: RestSearchDataStore) {
        self.area = area
        self.restSearchDataStore = restSearchDataStore
        self.restSearchDataStore.delegate = self
    }

    func attachView(view: RestaurantListView) {
        self.view = view
        let initializeTitle = String(format: "restDefaultTitle".localized(), area.areanameL)
        view.updateTitle(newTitle: initializeTitle)
    }

    func detachView() {
        self.view = nil
    }

    /// レストラン検索APIを実行する
    func searchRest() {
        view?.showIndicator()
        restSearchDataStore.executeAPI()
    }

    /// 追加読み込みをする
    func requestMore() {

        if restSearchDataStore.hasMoreRequest() {
            view?.showIndicator()
            restSearchDataStore.executeAPI()
        }
    }

    /// セルに値を設定する
    func configureCell(cell: RestaurantCell, at indexPath: IndexPath) {

        if let shopImageUrl = URL(string: restaurants[indexPath.row].imageUrl.shopImage) {
            cell.restaurantImageView.kf.setImage(with: shopImageUrl)
        }

        cell.restaurantNameLabel.text = restaurants[indexPath.row].name
        cell.stationLabel.text = String(format: "walkingTimeFromStation".localized(),
                                        restaurants[indexPath.row].access.station,
                                        restaurants[indexPath.row].access.walk)
        cell.addressLabel.text = restaurants[indexPath.row].address
        cell.telLabel.text = restaurants[indexPath.row].tel

        cell.budgetLabel.text = String(format: "budget".localized(), restaurants[indexPath.row].budget.decimalString)
    }
}

extension RestaurantListPresenter: RestSearchResult {

    func fetchSucceeded(restaurants: [Restaurant]) {

        let newTitle = String(format: "restTitle".localized(), area.areanameL, restSearchDataStore.total())
        view?.updateTitle(newTitle: newTitle)

        self.restaurants.append(contentsOf: restaurants)
        view?.reloadRestaurantList()

        restSearchDataStore.isLoading = false
        view?.hideIndicator()
    }

    func fetchFailed(errorMessage: String) {
        view?.hideIndicator()
        restSearchDataStore.isLoading = false
        view?.showError(message: errorMessage)
    }
}
