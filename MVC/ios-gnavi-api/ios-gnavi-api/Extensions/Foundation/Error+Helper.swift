//
//  Error+Helper.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

extension Error {
    
    var ns: NSError {
        return (self as NSError)
    }

    /// タイムアウトかどうか
    var isTimeout: Bool {
        return ns.domain == NSURLErrorDomain && ns.code == NSURLErrorTimedOut
    }

    /// オフラインかどうか
    var isOffline: Bool {
        return ns.domain == NSURLErrorDomain && ns.code == NSURLErrorNotConnectedToInternet
    }
}
