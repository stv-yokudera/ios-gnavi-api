//
//  AreasProvider.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

final class AreasProvider: NSObject {
    
    private var areas = [Area]()
    
    /// エリア情報の配列を設定する
    ///
    /// - Parameter areas: エリア情報の配列
    func add(areas: [Area]) {
        self.areas = areas
    }
    
    /// 選択されたエリア情報を取得する
    ///
    /// - Parameter indexPath: 選択されたIndexPath
    func selectedArea(indexPath: IndexPath) -> Area {
        return areas[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension AreasProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AreaCell"
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.text = areas[indexPath.row].areanameL
        return cell
    }
}
