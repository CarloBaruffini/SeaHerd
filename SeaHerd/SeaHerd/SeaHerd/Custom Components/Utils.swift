//
//  Utils.swift
//  SeaHerd
//
//  Created by Carlo Baruffini on 19/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import Foundation
import MapKit

/*** The following method shows a predefined alert
        The only argument of the method is the ViewController where the alert will be displayed
            Bye bye!
    vc : UIViewController - the VC where you want to display the alert
 */
public func showAlert(vc : UIViewController){
    let alert = UIAlertController(title: "Do you know?", message: "The Great Pacific Garbage Patch is 3 times the area of France!.", preferredStyle: .alert)

               alert.addAction(UIAlertAction(title: "Wow!", style: .default, handler: nil))

               vc.present(alert, animated: true)
}

//NSXMLParserDelegate needed for parsing the gpx files and NSObject is needed by NSXMLParserDelegate
class TrackDrawer: NSObject, XMLParserDelegate {
    //All filenames will be checked and if found and if it's a gpx file it will generate a polygon
    var fileNames: [String]! = [String]()

    init(fileNames: [String]) {
        self.fileNames = fileNames
    }

    //Needs to be a global variable due to the parser function which can't return a value
    private var boundaries = [CLLocationCoordinate2D]()

    //Create a polygon for each string there is in fileNames
    func getPolygons() -> [MKPolygon]? {
        //The list that will be returned
        var polyList: [MKPolygon] = [MKPolygon]()

        for fileName in fileNames! {
            //Reset the list so it won't have the points from the previous polygon
            boundaries = [CLLocationCoordinate2D]()

            //Convert the fileName to a computer readable filepath
            let filePath = getFilePath(fileName: fileName)

            if filePath == nil {
                print ("File \"\(fileName).gpx\" does not exist in the project. Please make sure you imported the file and dont have any spelling errors")
                continue
            }

            //Setup the parser and initialize it with the filepath's data
            let data = NSData(contentsOfFile: filePath!)
            let parser = XMLParser(data: data! as Data)
            parser.delegate = self

            //Parse the data, here the file will be read
            let success = parser.parse()

            //Log an error if the parsing failed
            if !success {
                print ("Failed to parse the following file: \(fileName).gpx")
            }
            //Create the polygon with the points generated from the parsing process
            polyList.append(MKPolygon(coordinates: &boundaries, count: boundaries.count))

        }
        return polyList
    }

    func getFilePath(fileName: String) -> String? {
        //Generate a computer readable path
        return Bundle.main.path(forResource: fileName, ofType: "gpx")
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //Only check for the lines that have a <trkpt> or <wpt> tag. The other lines don't have coordinates and thus don't interest us
        if elementName == "trkpt" || elementName == "wpt" {
            //Create a World map coordinate from the file
            let lat = attributeDict["lat"]!
            let lon = attributeDict["lon"]!

            boundaries.append(CLLocationCoordinate2DMake(CLLocationDegrees(lat)!, CLLocationDegrees(lon)!))
        }
    }
}
