//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 09/05/2022.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)

    }

}

