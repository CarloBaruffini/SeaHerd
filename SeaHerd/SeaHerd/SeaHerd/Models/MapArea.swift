//
//  PacificOcean.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit

/// This class is used to get map area info from a plist file
class MapArea {
    var name: String?
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            // Evalutated to be at the same latitude of the of the bottom left corner and longitude of the top right corner
            return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                              overlayTopRightCoordinate.longitude)
        }
    }
    
    /// The bounding box of the map
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPoint(overlayTopLeftCoordinate)
            let topRight = MKMapPoint(overlayTopRightCoordinate)
            let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
            
            return MKMapRect(
                x: topLeft.x,
                y: topLeft.y,
                width: fabs(topLeft.x - topRight.x),
                height: fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    init(filename: String) {
        // Try to deserialize the plist files
        guard let properties = MapArea.plist(filename) as? [String : Any] else { return }
        
        /// Extract the midCoordinate, and the borders of the area
        midCoordinate = MapArea.parseCoordinate(dict: properties, fieldName: "midCoord")
        overlayTopLeftCoordinate = MapArea.parseCoordinate(dict: properties, fieldName: "overlayTopLeftCoord")
        overlayTopRightCoordinate = MapArea.parseCoordinate(dict: properties, fieldName: "overlayTopRightCoord")
        overlayBottomLeftCoordinate = MapArea.parseCoordinate(dict: properties, fieldName: "overlayBottomLeftCoord")
    }
    
    /// Method to deserialize the property list
    /// - Parameter plist: the plist file name
    class func plist(_ plist: String) -> Any? {
        let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
        let data = FileManager.default.contents(atPath: filePath)!
        
        // Returns a dictionary with keys-values of the file
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    }
    
    /// Given a dictionary and a field name parse a CLLocationCoordinate2D
    /// - Parameter dict: the dictionary that contains coordinate name:location
    /// - Parameter fieldName: the name of the coordinate to extract
    static func parseCoordinate(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
            return CLLocationCoordinate2D()
        }
        let point = NSCoder.cgPoint(for: coord)
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }
}
