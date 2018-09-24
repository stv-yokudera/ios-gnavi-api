//
//  UIStoryboard+InstantiateViewController.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/23.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

extension UIStoryboard {

    /// Storyboardからインスタンスを取得する
    class func viewController<T: UIViewController>(storyboardName: String, identifier: String) -> T? {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}
