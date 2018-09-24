//
//  AppDelegate.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit
import Model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let areaListVC = ViewControllerBuilder.buildAreaList(service: AreaListService())
        window?.rootViewController = UINavigationController(rootViewController: areaListVC)
        window?.makeKeyAndVisible()
        return true
    }
}
