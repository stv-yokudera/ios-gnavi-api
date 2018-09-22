//
//  AreasLoader.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import UIKit

/// エリア情報読み込み結果を通知するプロトコル
protocol AreasLoadResult: class {
    func loadSucceeded(areas: [Area])
    func loadFailed(errorMessage: String)
}

/// エリア情報を読み込むクラス
final class AreasLoader: NSObject {

    weak var delegate: AreasLoadResult?
    
    func load(prefName: String = "東京都") {
        
        let loadFailedMessage = "loadFailedMSG".localized()
        
        do {
            guard let jsonData = try JSONFileReader.read(fileName: Constants.areaJsonFileName) else {
                print("jsonData is nil.")
                delegate?.loadFailed(errorMessage: loadFailedMessage)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let gAreaLarge = try jsonDecoder.decode(GAreaLarge.self, from: jsonData).gareaLarge else {
                print("gareaLarge is nil.")
                delegate?.loadFailed(errorMessage: loadFailedMessage)
                return
            }
            
            let areas = gAreaLarge.filter {
                $0.pref?.prefName == prefName
            }
            delegate?.loadSucceeded(areas: areas)
            
        } catch {
            print(error)
            delegate?.loadFailed(errorMessage: loadFailedMessage)
        }
    }
}
