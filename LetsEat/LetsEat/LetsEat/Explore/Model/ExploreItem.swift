//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Adam Palmer on 25/04/2022.
//

import Foundation

struct ExploreItem {
    
    let name: String?
    let image: String?
    
}

extension ExploreItem {
    
    init(dict: [String: String]) {
        
        self.name = dict["name"]
        self.image = dict["image"]
        
    }
}
