//
//  UIViewController+Alert.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

extension UIViewController {

    func showSingleButtonAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized(), style: .default, handler: handler)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
