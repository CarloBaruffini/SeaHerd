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
    
    var operationTime: Int = 0
    var initialPos: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapArea = MapArea(filename: "PacificOcean")
        let location = mapArea.midCoordinate
        lookUpCurrentLocation(location: location) { (placemark) in
            DispatchQueue.main.async {
                self.locationLabel.text = placemark?.name
            }
        }
        operationTime = 3709876
        updateOperationTime(seconds: operationTime)
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.operationTime = self.operationTime + Int(timer.timeInterval)
            self.updateOperationTime(seconds: self.operationTime)
        }
        self.initialPos = jellyImageView.frame.origin.y
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.jellyImageView.frame.origin.y += 20
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        jellyImageView.frame.origin.y = initialPos
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

    private func updateOperationTime(seconds: Int){
        DispatchQueue.main.async {
            self.operationTimeLabel.text = self.secondsToDayHoursMinutesSeconds(seconds: seconds)
        }
    }
    
    private func secondsToDayHoursMinutesSeconds (seconds : Int) -> String {
        return "\( seconds / (24 * 3600) )d, \( (seconds % (24 * 3600)) / 3600 )h, \((seconds % 3600) / 60)m, \((seconds % 3600) % 60)s"
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
