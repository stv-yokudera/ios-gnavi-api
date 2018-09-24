//
//  AreaListViewController.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

final class AreaListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var areaListPresenter: AreaListPresenter!
    
    // MARK: - Life cycle
    
    deinit {
        areaListPresenter.detachView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
    
    // MARK: - Others
    
    private func setup() {
        areaListPresenter.attachView(view: self)
        areaListPresenter.loadAreaList()
    }
}

extension AreaListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaListPresenter.areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AreaCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = areaListPresenter.areas[indexPath.row].areanameL
        return cell
    }
}

extension AreaListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        areaListPresenter.buildNextScreen(indexPath: indexPath)
    }
}

extension AreaListViewController: AreaListView {
    
    func showError(message: String) {
        showSingleButtonAlert(title: "Error".localized(), message: message)
    }
    
    func reloadAreaList() {
        tableView.reloadData()
    }
    
    func transition(vc: RestaurantListViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
