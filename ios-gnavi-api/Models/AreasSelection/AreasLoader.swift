//
//  AreasLoader.swift
//  ios-gnavi-api
//
//  Created by OkuderaYuki on 2017/11/14.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

protocol AreasLoadable: class {
    func loadedThen(areas: [Area])
    func failedThen()
}

final class AreasLoader {

    weak var loadable: AreasLoadable?
    
    func load(prefName: String) {
        
        guard let path = Bundle.main.path(forResource: "area", ofType: "json") else {
            fatalError("area.json is not found in main Bundle.")
        }
        
        do {
            
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            let jsonDecoder = JSONDecoder()
            let gAreaLarge = try jsonDecoder.decode(GAreaLarge.self, from: jsonData).gareaLarge
            
            let areas = gAreaLarge?.filter {
                $0.pref?.prefName == prefName
            }

            if let areas = areas {
                loadable?.loadedThen(areas: areas)
            } else {
                loadable?.failedThen()
            }
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
    }
}
