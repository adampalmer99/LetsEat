//
//  MapViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 06/05/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    private let manager = MapDataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

        // Do any additional setup after loading the view.
    }
    
    func initialize() {
        manager.fetch { (annotations) in setupMap(annotations)}
    }
    
    func setupMap (_ annotations: [RestaurantItem]) {
        mapView.setRegion(manager.initialRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }

    

}
