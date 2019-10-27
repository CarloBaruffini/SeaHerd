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

    @IBOutlet weak var titleView: UIView!
    
    let jellyfish = MKPointAnnotation()
    
    /// Defines the ocean area shown in the map
    let jellyArea = MapArea(filename: "PacificOcean")
    
    /// Defines the names of the jellybot shown in the ocean
    var jelliesName = ["JB-12E5HU",
                       "JB-129UY6",
                       "JB-26HU8E",
                       "JB-02O9P8"]
    
    override func viewDidLoad() {
        
        // Set the controller as delegate of the mapview
        self.mapView.delegate = self
        
        // Adds blurr effect on the title view
        titleView.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = titleView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        titleView.insertSubview(blurEffectView, at: 0)
        
        // Define the distance from the ocean top left coordinate to the ocean bottom right coordinate.
        let latDelta = jellyArea.overlayTopLeftCoordinate.latitude - jellyArea.overlayBottomRightCoordinate.latitude
        
        // Span is the measure from one corner to another
        let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: jellyArea.midCoordinate, span: span)
        
        mapView.region = region
        
        self.addOverlay()
        self.addJellyfishPins()
        self.addPath(fileName: "JellyPath")
        self.addPath(fileName: "JellyPathClosed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
      let manager = NotificationManager()
      manager.notifications = [
          Notification(id: "reminder-1", title: "The Jellybot is on the move again!")
      ]
      manager.schedule()
      }
    
    /// Add a MapOverlay to the map view
    func addOverlay() {
        let overlay = MapOverlay(mapArea: self.jellyArea)
        self.mapView.addOverlay(overlay)
    }
    
    /// Add on the map the annotation for each jellyfish to display
    func addJellyfishPins() {
        let annotation = JellyfishAnnotation(coordinate: self.jellyArea.midCoordinate, title: "JB-12E4GE", subtitle: "")
        self.mapView.addAnnotation(annotation)
        
        guard let points = MapArea.plist("JelliesLocation") as? [String] else { return }
        
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        for coord in coords {
            let name = jelliesName.popLast() ?? "JB-TEST"
            let annotation = JellyfishAnnotation(coordinate: coord, title: name, subtitle: "")
            self.mapView.addAnnotation(annotation)
        }
    }
    
    /// Add to the map the path of the jellyfish
    func addPath(fileName: String) {
        guard let points = MapArea.plist(fileName) as? [String] else { return }
        
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
        myPolyline.title = fileName
        
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
            lineView.strokeColor = UIColor(hexFromString: "#003D61")
            lineView.lineWidth = 8
            
            if overlay.title == "JellyPathClosed" {
                lineView.lineDashPhase = 2
                lineView.lineDashPattern = [NSNumber(value: 4),NSNumber(value: 10)]
                lineView.alpha = 0.7
                lineView.strokeColor = UIColor(hexFromString: "#003D61")
            }
            
            return lineView
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = JellyfishAnnotationView(annotation: annotation, reuseIdentifier: annotation.title == "JB-12E4GE" ? "jellyfish" : "jellyfish2")
        annotationView.canShowCallout = true
        annotationView.frame.size = CGSize(width: 50, height: 50)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title
        {
            if annotationTitle == "JB-12E4GE" {
                tabBarController!.selectedIndex = 1
                mapView.bringSubviewToFront(view)
            }
        }
    }

}
