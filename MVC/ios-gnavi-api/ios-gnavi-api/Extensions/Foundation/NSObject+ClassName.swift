//
//  NSObject+ClassName.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

public extension NSObject {

    /// クラス名を取得する
    static var className: String {
        get {
            return String(describing: self)
        }
    }
}
