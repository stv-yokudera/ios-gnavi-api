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
    
    var restaurantListPresenter: RestaurantListPresenter!
    
    // MARK: - Life cycle

    deinit {
        restaurantListPresenter.detachView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Others
    
    private func setup() {
        
        RestaurantCell.register(tableView: tableView)
        restaurantListPresenter.attachView(view: self)
        restaurantListPresenter.searchRest()
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantListPresenter.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = RestaurantCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantCell
        restaurantListPresenter.configureCell(cell: cell, at: indexPath)
        return cell
    }
}

extension RestaurantListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height
            && scrollView.isDragging else {
                return
        }
        restaurantListPresenter.requestMore()
    }
}

extension RestaurantListViewController: NVActivityIndicatorViewable {}

extension RestaurantListViewController: RestaurantListView {
    
    func showError(message: String) {
        showSingleButtonAlert(title: "Error".localized(), message: message)
    }
    
    func showIndicator() {
        startAnimating()
    }
    
    func hideIndicator() {
        stopAnimating()
    }
    
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
    
    func reloadRestaurantList() {
        tableView.reloadData()
    }
}
