//
//  UITableViewCell+Identifier.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}
