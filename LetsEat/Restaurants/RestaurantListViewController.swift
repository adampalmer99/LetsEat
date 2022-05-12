//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 25/04/2022.
//

import UIKit

class RestaurantListViewController: UIViewController, UICollectionViewDelegate {
    
    private let manager = RestaurantDataManager()
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedCuisine: String?
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createData()
        setupTitle()
        guard let city = selectedCity?.city, let cuisine = selectedCuisine else {
            return
        }
        let manager = RestaurantDataManager()
        manager.fetch(location: city, selectedCuisine: cuisine) {
            RestaurantItems in if !RestaurantItems.isEmpty {
                for RestaurantItem in RestaurantItems {
                    if let restaurantName = RestaurantItem.name {
                        print(restaurantName)
                    }
                }
            } else {
                print("No data")
            }
        }
    }
}


// MARK: Private Extension

private extension RestaurantListViewController {
    
    func createData() {
        guard let city = selectedCity?.city, let cuisine = selectedCuisine else {
            return
        }
        manager.fetch(location: city, selectedCuisine: cuisine) {restaurantItems in if !restaurantItems.isEmpty {
            collectionView.backgroundView = nil
        } else {
            let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
            view.set(title: "Restaurants", desc: "No restaurants found.")
            collectionView.backgroundView = view
        }
            collectionView.reloadData()
        }
    }
    
    func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = selectedCity?.cityAndState.uppercased()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: RestaurantListViewController

extension RestaurantListViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manager.numberOfRestaurantItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let restaurantItem = manager.restaurantItem(at: indexPath.row)
        cell.titleLabel.text = restaurantItem.name
        if let cuisine = restaurantItem.subtitle {
            cell.cuisineLabel.text = cuisine
        }
        if let imageURL = restaurantItem.imageURL {
            if let url = URL(string: imageURL) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.restaurantImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }
}
