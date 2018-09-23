//
//  RestaurantListViewController.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class RestaurantListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var area: Area!
    private var restSearchDataStore: RestSearchDataStore!

    private let listProvider = RestaurantListProvider()

    static func build(area: Area) -> RestaurantListViewController {

        let vcName = RestaurantListViewController.className
        let vc = UIStoryboard.viewController(
            storyboardName: vcName, identifier: vcName
            ) as! RestaurantListViewController
        vc.area = area
        vc.restSearchDataStore = RestSearchDataStore(areaCode: area.areacodeL)

        return vc
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Others

    private func setup() {

        setupTitle()

        RestaurantCell.register(tableView: tableView)
        tableView.dataSource = listProvider

        restSearchDataStore = RestSearchDataStore(areaCode: area.areacodeL)
        restSearchDataStore.delegate = self

        startAnimating()
        restSearchDataStore.executeAPI()
    }

    private func setupTitle() {
        self.title = String(format: "restDefaultTitle".localized(), area.areanameL)
    }

    private func updateTitle() {
        self.title = String(format: "restTitle".localized(), area.areanameL, restSearchDataStore.total())
    }
}

extension RestaurantListViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height
            && scrollView.isDragging else {
                return
        }

        if restSearchDataStore.hasMoreRequest() {
            startAnimating()
            restSearchDataStore.executeAPI()
        }
    }
}

extension RestaurantListViewController: RestSearchResult {

    func fetchSucceeded(restaurants: [Restaurant]) {
        updateTitle()
        listProvider.add(restaurants: restaurants)
        tableView.reloadData()
        restSearchDataStore.isLoading = false
        stopAnimating()
    }

    func fetchFailed(errorMessage: String) {
        stopAnimating()
        restSearchDataStore.isLoading = false
        showSingleButtonAlert(title: "Error".localized(), message: errorMessage)
    }
}

extension RestaurantListViewController: NVActivityIndicatorViewable {}
