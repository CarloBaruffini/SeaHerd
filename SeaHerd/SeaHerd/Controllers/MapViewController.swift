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
    let trackDrawer = TrackDrawer(fileNames: ["jelly_route"])
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let location = CLLocationCoordinate2D(latitude: 32.026458, longitude: 32.026458)
        self.jellyfish.coordinate = location
        self.jellyfish.title = "Scusa, mi tocchi la medusa?"
        
        self.mapView.addAnnotation(self.jellyfish)
        self.movePosition()
        
        guard let polygon = self.trackDrawer.getPolygons() else { return }
        let polygonView = MKPolygonRenderer(overlay: polygon)
        polygonView.strokeColor = UIColor.magenta

        self.mapView.addOverlay(polygon)
    }
    
    func movePosition() {
        // Set timer to run after 5 seconds.
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            // Set animation to last 4 seconds.
            UIView.animate(withDuration: 4, animations: {
                // Update annotation coordinate to be the destination coordinate
                //self?.jellyfish.coordinate =
            }, completion: nil)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
}

extension MapViewController: MKMapViewDelegate {
    
}
