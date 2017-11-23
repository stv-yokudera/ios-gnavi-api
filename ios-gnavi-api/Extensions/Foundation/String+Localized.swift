//
//  String+Localized.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/23.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
