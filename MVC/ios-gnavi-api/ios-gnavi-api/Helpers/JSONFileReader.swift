//
//  JSONFileReader.swift
//  ios-gnavi-api
//
//  Created by YukiOkudera on 2018/09/22.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

final class JSONFileReader: NSObject {

    /// JSONファイル名を指定して、データを取得する
    ///
    /// - Parameter fileName: e.g. "area.json"
    /// - Returns: main bundleに対象ファイルが存在しない場合: nil, 存在する場合: Data
    /// - Throws: urlが読み込めない場合に発生するエラー
    static func read(fileName: String) throws -> Data? {

        let resourceName = fileName.deletingPathExtension
        let resourceType = fileName.pathExtension
        guard let jsonFilePath = Bundle.main.path(forResource: resourceName, ofType: resourceType) else {
            return nil
        }

        let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
        return try Data(contentsOf: jsonFileURL)
    }
}
