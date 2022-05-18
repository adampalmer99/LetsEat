//
//  FilterItem.swift
//  LetsEat
//
//  Created by Adam Palmer on 16/05/2022.
//

import Foundation

struct FilterItem {
    let filter: String?
    let name: String?
    init(dict: [String: String]) {
        self.filter = dict["filter"]
        self.name = dict["name"]
    }
}
