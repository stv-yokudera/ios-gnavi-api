//
//  Int+DecimalString.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
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
