//
//  RestaurantListViewController.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import SVProgressHUD
import UIKit

final class RestaurantListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var area: Area?
    private let restaurantListProvider = RestaurantListProvider()
    private let restaurantSearchAPI = RestaurantSearchAPI()
    private var restaurantSearchStatus = RestaurantSearchStatus.loadingThen
    
    // MARK: - Factory
    
    class func create(area: Area) -> RestaurantListViewController {

        let restaurantListVCName = RestaurantListViewController.className
        let storyboard = UIStoryboard(name: restaurantListVCName, bundle: .main)

        if let vc = storyboard.instantiateViewController(
            withIdentifier: restaurantListVCName) as? RestaurantListViewController {

            vc.area = area
            return vc
        }
        fatalError("RestaurantListViewController is nil.")
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods

    private func setup() {

        tableView.delegate = self
        tableView.dataSource = restaurantListProvider
        restaurantSearchAPI.loadable = self

        setupTitle()

        executeRestaurantSearchAPI()
    }

    private func setupTitle() {

        if let areaName = area?.areanameL {
            self.title = String(format: "REST_DEFAULT_TITLE".localized(), areaName)
        }
    }

    private func updateTitle() {

        if let areaName = area?.areanameL {
            self.title = String(format: "REST_TITLE".localized(),
                                areaName,
                                restaurantSearchAPI.total())
        }
    }

    private func executeRestaurantSearchAPI() {

        guard let areaCode = area?.areacodeL, !areaCode.isEmpty else {
            
            showAlert(message: "AREA_CODE_IS_NOT_SET".localized(),
                      handler: { [weak self] _ in
                        self?.navigationController?.popViewController(animated: true)
            })
            return
        }

        SVProgressHUD.show()
        restaurantSearchAPI.load(areaCode: areaCode)
    }

    /// レストラン一覧取得完了後の処理
    ///
    /// - Parameter restArray: レストラン一覧
    private func loaded(restArray: [Rest]) {

        updateTitle()
        restaurantListProvider.add(restArray: restArray)
        tableView.reloadData()
    }
}

// MARK: - RestaurantSearchLoadable
extension RestaurantListViewController: RestaurantSearchLoadable {

    func searchResult(result: RestaurantSearchStatus) {

        restaurantSearchStatus = result

        if case .loadingThen = restaurantSearchStatus {
            return
        }

        SVProgressHUD.dismiss()

        switch restaurantSearchStatus {

        case .loadedThen(restArray: let restArray):
            loaded(restArray: restArray)

        case .offlineThen:
            showAlert(message: "REST_SEARCH_RESULT_OFFLINE".localized())

        case .errorThen:
            showAlert(message: "REST_SEARCH_RESULT_ERROR".localized())

        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension RestaurantListViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if case .loadingThen = restaurantSearchStatus {
            return
        }

        guard scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height
            && scrollView.isDragging else {
                return
        }
        
        if restaurantSearchAPI.hasMoreRequest() {
            executeRestaurantSearchAPI()
        }
    }
}
