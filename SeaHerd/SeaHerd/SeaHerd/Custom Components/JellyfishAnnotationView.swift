//
//  JellyfishAnnotation.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit

/// Class to display custom image for jellyfish annotation
class JellyfishAnnotationView: MKAnnotationView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = UIImage(imageLiteralResourceName: reuseIdentifier == "jellyfish" ? "jellyfish.png" : "Jelly.png")
        if (reuseIdentifier == "jellyfish") {
            UIView.animate(withDuration: 3 .0, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.frame.origin.y += 20
            })
        } else {
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [.repeat, .autoreverse], animations: {
                self.frame.origin.y += 10
            })
        }
        
    }
}
