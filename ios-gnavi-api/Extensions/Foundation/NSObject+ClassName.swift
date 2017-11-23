//
//  NSObject+ClassName.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/15.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// クラス名を取得する
    static var className: String {
        return String(describing: self)
    }
}
