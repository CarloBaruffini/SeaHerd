//
//  MapViewController.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let jellyfish = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: 32.026458, longitude: 32.026458)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.jellyfish.coordinate = location
        self.jellyfish.title = "Scusa, mi tocchi la medusa?"
        
        self.mapView.addAnnotation(self.jellyfish)

    }
    
    
    @IBOutlet weak var mapView: MKMapView!
}
