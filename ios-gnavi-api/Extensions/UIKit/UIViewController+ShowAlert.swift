//
//  UIViewController+ShowAlert.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/23.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// OKボタンのみのアラートを表示する
    ///
    /// - Parameter message: メッセージ
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = AlertHelper.alert(message: message, rightButtonAction: handler)
        self.present(alert, animated: true, completion: nil)
    }
}
