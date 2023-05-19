//
//  MapViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 17/05/23.
//

import AVFoundation
import CoreLocation
import Foundation
import MapKit
import UIKit


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapsView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapsView.delegate = self
        mapsView.showsUserLocation = true
        mapsView.mapType = MKMapType(rawValue: 0)!
        mapsView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        
        
        // user activated automatic authorization info mode
        var status = locationManager.authorizationStatus
        
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
              print("location is not authorized for application")
               locationManager.requestAlwaysAuthorization()
               locationManager.requestWhenInUseAuthorization()
           }
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
    }
    
    @IBAction func startPressed(_ sender: Any) {
        
        func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
            print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
            // Debug->Location->City Bicycle Ride
            if let oldLocationNew = oldLocation as CLLocation?{
                let oldCoordinates = oldLocationNew.coordinate
                let newCoordinates = newLocation.coordinate
                var area = [oldCoordinates, newCoordinates]
                var polyline = MKPolyline(coordinates: &area, count: area.count)
                self.mapsView.addOverlay(polyline)
            }

        }
        
        func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
            if (overlay is MKPolyline) {
                var pr = MKPolylineRenderer(overlay: overlay)
                pr.strokeColor = .red
                pr.lineWidth = 5
                return pr
            }
            return nil
        }
        
        
    }
    
    
    @IBAction func stopPressed(_ sender: Any) {
    }
    
    
    
    
}


