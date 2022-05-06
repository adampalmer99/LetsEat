//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Adam Palmer on 05/05/2022.
//

import Foundation

class MapDataManager: DataManager {
    private var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        items
    }
    
    
    func fetch(completion: (_ annotations: [RestaurantItem]) -> ()) {
        if !items.isEmpty {
            items.removeAll()
        }
        for data in loadPlist(file: "MapLocations") {
            items.append(RestaurantItem(dict: data))
        }
        completion(items)
    }
}
