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

    private let areasLoader = AreasLoader()
    private let listProvider = AreaListProvider()

    // MARK: - Life cycle

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
        tableView.dataSource = listProvider
        areasLoader.delegate = self
        areasLoader.load()
    }
}

extension AreaListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        // TODO: - レストラン一覧画面にAreaオブジェクトを渡して遷移する
    }
}

extension AreaListViewController: AreasLoadResult {

    func loadSucceeded(areas: [Area]) {
        listProvider.areas = areas
        tableView.reloadData()
    }
    
    func loadFailed(errorMessage: String) {
        showSingleButtonAlert(title: "Error".localized(), message: errorMessage)
    }
}
