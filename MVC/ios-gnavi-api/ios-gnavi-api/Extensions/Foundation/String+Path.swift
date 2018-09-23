//
//  String+Path.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

extension String {

    private var ns: NSString {
        return (self as NSString)
    }

    /// 拡張子を取得する
    var pathExtension: String {
        return ns.pathExtension
    }
    
    /// 拡張子を削除する
    var deletingPathExtension: String {
        return ns.deletingPathExtension
    }
}
