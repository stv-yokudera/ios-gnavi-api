//
//  AreaListService.swift
//  Model
//
//  Created by YukiOkudera on 2018/09/24.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

/// エリア情報読み込み結果を通知するプロトコル
public protocol AreasLoadResult: class {
    func loadSucceeded(areas: [Area])
    func loadFailed(errorMessage: String)
}

/// エリア情報を読み込むクラス
final public class AreaListService {

    public init() {}

    public weak var delegate: AreasLoadResult?

    public func load(prefName: String = "東京都") {

        do {
            guard let jsonData = try JSONFileReader.read(fileName: Constants.areaJsonFileName) else {
                print("jsonData is nil.")
                delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let gAreaLarge = try jsonDecoder.decode(GAreaLarge.self, from: jsonData).gareaLarge else {
                print("gareaLarge is nil.")
                delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
                return
            }

            let areas = gAreaLarge.filter {
                $0.pref?.prefName == prefName
            }
            delegate?.loadSucceeded(areas: areas)

        } catch {
            print(error)
            delegate?.loadFailed(errorMessage: Constants.loadFailedMessage)
        }
    }
}
