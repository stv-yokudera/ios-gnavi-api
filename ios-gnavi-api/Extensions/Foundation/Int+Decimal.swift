//
//  Int+Decimal.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/18.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation

extension Int {

    /// 3桁毎にカンマが入ったStringへ変換する
    var decimalString: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3

        return decimalFormatter.string(from: self as NSNumber)!
    }
}
