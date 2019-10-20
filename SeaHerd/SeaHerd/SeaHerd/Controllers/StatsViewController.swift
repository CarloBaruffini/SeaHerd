//
//  StatsViewController.swift
//  SeaHerd
//
//  Created by Pasquale Vittoriosi on 20/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import UIKit
import MapKit

class StatsViewController: UIViewController {

    @IBOutlet weak var nudgeTextView: UITextView!
    @IBOutlet weak var operationTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var jellyImageView: UIImageView!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapArea = MapArea(filename: "PacificOcean")
        var location = mapArea.midCoordinate
        lookUpCurrentLocation(location: location) { (questo) in
            self.locationLabel.text = questo?.name
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.jellyImageView.frame.origin.y += 20
        })
        // Do any additional setup after loading the view.
        
        self.operationTimeLabel.text = "2 days 3 hours"
        
    }
    func lookUpCurrentLocation(location: CLLocationCoordinate2D?, completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = location {
            let geocoder = CLGeocoder()
                
            let clLocation = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(clLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
