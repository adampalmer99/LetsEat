//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 09/05/2022.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    // Nav Bar
    @IBOutlet var heartButton: UIBarButtonItem!
    // Cell One
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var headerAddressLabel: UILabel!
    // Cell Two
    @IBOutlet var tableDetailsLabel: UILabel!
    // Cell Three
    @IBOutlet var overallRatingLabel: UILabel!
    // Cell Eight
    @IBOutlet var addressLabel: UILabel!
    // Cell Nine
    @IBOutlet var locationMapImageView: UIImageView!
    
    @IBOutlet var  ratingsView: RatingsView!
    
    
    
    
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()

    }
}

private extension RestaurantDetailViewController {
 
    func initialise() {
        setupLabels()
        creaateMap()
        createRating()
    }
    
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {
        
    }
    
    func createRating() {
        ratingsView.rating = 3.5
        ratingsView.isEnabled = true
    }
    
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else {
            return
        }
        title = restaurant.name
        nameLabel.text = restaurant.name
        cuisineLabel.text = restaurant.subtitle
        headerAddressLabel.text = restaurant.address
        tableDetailsLabel.text = "Table for 7, tonight at 10:00 PM"
        addressLabel.text = restaurant.address
    }
    
    
    func creaateMap() {
        guard let annotation = selectedRestaurant, let long = annotation.long, let lat = annotation.lat else {
            return
        }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapshot(with: location)
    }
    
    func takeSnapshot(with location: CLLocationCoordinate2D) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start() {
            snapshot, error in guard let snapshot = snapshot else {
                return
            }
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.locationMapImageView.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.locationMapImageView.image = image
                }
            }
        }
    }
}
