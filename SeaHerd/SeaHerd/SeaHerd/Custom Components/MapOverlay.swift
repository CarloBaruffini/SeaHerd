//
//  MapOverlay.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit

/// Class that specifies where where to draw the overlay (the area where the jellyfish path will be shown)
class MapOverlay: NSObject, MKOverlay {
    // Defines where the overlay resides on the map
    var coordinate: CLLocationCoordinate2D
    // Defines the overlay size
    var boundingMapRect: MKMapRect
    
    init (mapArea: MapArea) {
        // Set the overlay in the same position and extended as the map area
        boundingMapRect = mapArea.overlayBoundingMapRect
        coordinate = mapArea.midCoordinate
    }
}
