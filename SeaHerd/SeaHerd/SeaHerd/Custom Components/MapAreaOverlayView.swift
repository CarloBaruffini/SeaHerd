//
//  MapAreaOverlayView.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit

/// Class that specifies what to draw in an overlay
class MapAreaOverlayView: MKOverlayRenderer {
  var overlayImage: UIImage
  
  init (overlay:MKOverlay, overlayImage:UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }
  
  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    guard let imageReference = overlayImage.cgImage else { return }
    
    let rect = self.rect(for: overlay.boundingMapRect)
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -rect.size.height)
    context.draw(imageReference, in: rect)
  }
}
