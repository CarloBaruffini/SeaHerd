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
    
    /// Defines the ocean area shown in the map
    let jellyArea = MapArea(filename: "PacificOcean")
    
    override func viewDidLoad() {
        // Set the controller as delegate of the mapview
        self.mapView.delegate = self
        
        // Define the distance from the ocean top left coordinate to the ocean bottom right coordinate.
        let latDelta = jellyArea.overlayTopLeftCoordinate.latitude - jellyArea.overlayBottomRightCoordinate.latitude
        
        // Span is the measure from one corner to another
        let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: jellyArea.midCoordinate, span: span)
        
        mapView.region = region
        
        self.addOverlay()
        self.addJellyfishPins()
        self.addPath()
    }
    
    /// Add a MapOverlay to the map view
    func addOverlay() {
        let overlay = MapOverlay(mapArea: self.jellyArea)
        self.mapView.addOverlay(overlay)
    }
    
    /// Add on the map the annotation for each jellyfish to display
    func addJellyfishPins() {
        let annotation = JellyfishAnnotation(coordinate: self.jellyArea.midCoordinate, title: "Scusa, mi  tocchi la medusa?", subtitle: "")
        mapView.addAnnotation(annotation)
    }
    
    /// Add to the map the path of the jellyfish
    func addPath() {
        guard let points = MapArea.plist("JellyPath") as? [String] else { return }
        
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
        mapView.addOverlay(myPolyline)
    }
    
    /// Outlet of the map view
    @IBOutlet weak var mapView: MKMapView!
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    /// MapView calls this methos when there is an overlay in the area that the map is displaying
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.green
            return lineView
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = JellyfishAnnotationView(annotation: annotation, reuseIdentifier: "jellyfish")
        annotationView.canShowCallout = true
        return annotationView
    }
    
}
