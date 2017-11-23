//
//  AreasSelectionViewController.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/14.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

final class AreasSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let provider = AreasProvider()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        
        tableView.dataSource = provider
        
        let areasLoader = AreasLoader()
        areasLoader.loadable = self
        // 東京都のエリア情報を取得する
        areasLoader.load(prefName: "東京都")
    }
}

// MARK: - UITableViewDelegate
extension AreasSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedArea = provider.selectedArea(indexPath: indexPath)
        let restaurantListVC = RestaurantListViewController.create(area: selectedArea)
        self.navigationController?.pushViewController(restaurantListVC, animated: true)
    }
}

// MARK: - AreasLoadable
extension AreasSelectionViewController: AreasLoadable {
    
    func loadedThen(areas: [Area]) {
        provider.add(areas: areas)
    }
    
    func failedThen() {
        showAlert(message: "AREAS_LOAD_ERROR".localized())
    }
}
