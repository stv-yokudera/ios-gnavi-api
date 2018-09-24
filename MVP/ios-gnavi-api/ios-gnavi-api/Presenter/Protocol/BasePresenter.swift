//
//  BasePresenter.swift
//  Presenter
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

protocol BasePresenter {

    associatedtype View

    func attachView(view: View)

    func detachView()
}
