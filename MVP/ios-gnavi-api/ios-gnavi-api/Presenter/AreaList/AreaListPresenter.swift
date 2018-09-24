//
//  AreaListPresenter.swift
//  Presenter
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit
import Model

final class AreaListPresenter: BasePresenter {

    private let service: AreaListService
    weak private var view: AreaListView?
    private(set) var areas = [Area]()

    init(service: AreaListService) {
        self.service = service
        self.service.delegate = self
    }

    func attachView(view: AreaListView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func loadAreaList() {
        service.load()
    }

    func buildNextScreen(indexPath: IndexPath) {
        let restSearchDataStore = RestSearchDataStore(areaCode: areas[indexPath.row].areacodeL)
        let restaurantListVC = ViewControllerBuilder.buildRestaurantList(area: areas[indexPath.row],
                                                                         restSearchDataStore: restSearchDataStore)
        view?.transition(vc: restaurantListVC)
    }
}

extension AreaListPresenter: AreasLoadResult {

    func loadSucceeded(areas: [Area]) {
        self.areas = areas
        view?.reloadAreaList()
    }

    func loadFailed(errorMessage: String) {
        view?.showError(message: errorMessage)
    }
}
