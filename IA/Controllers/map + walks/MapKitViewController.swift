//
//  MapKitViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 23/07/23.
//


import UIKit
import RealmSwift
import MapKit

class MapViewController: LocationVCViewController {
    
    
    @IBOutlet weak var durationLabel: UITextField!
    @IBOutlet weak var distanceLabel: UITextField!
    
    @IBOutlet weak var lastDurationLabel: UILabel!
    @IBOutlet weak var lastDistanceLabel: UILabel!
    @IBOutlet weak var lastRunCloseButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var coordinateLocations = List<Location>()
    var timer = Timer()
    var walkDistance = 0.0
    var counter = 0
    
    @IBOutlet weak var lastRunStack: UIStackView!
    @IBOutlet weak var lastRunBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        manager?.delegate = self
        manager?.distanceFilter = 10
        getLastWalk()
    }
    
    @IBAction func lastRunClosedPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBackgroundView.isHidden = true
        lastRunCloseButton.isHidden = true
        
    }
    
    func startWalk(){
        manager?.startUpdatingLocation()
        startTimer()
        
    }
    
    func getLastWalk(){
        guard let lastWalk = Walk.getAllWalks()?.first else {
            lastRunStack.isHidden = true
            lastRunBackgroundView.isHidden = true
            lastRunCloseButton.isHidden = true
            return
        }
        lastRunStack.isHidden = false
        lastRunBackgroundView.isHidden = false
        lastRunCloseButton.isHidden = false
        lastDistanceLabel.text = (String(format: "%02d", lastWalk.distance))
        lastDurationLabel.text = lastWalk.duration.formatTimeDurationToString()
        
    }
    
    
    func endWalk(){
        manager?.stopUpdatingLocation()
        Walk.addWalkToRealm(distance: walkDistance , duration: counter, locations: coordinateLocations)
        walkDistance = 0.0
        counter = 0
        durationLabel.text = counter.formatTimeDurationToString()
        distanceLabel.text = "Distance: \(String(format: "%02d", walkDistance))m"
    }
    
    func pauseWalk(){
        
        startLocation = nil
               lastLocation = nil
               timer.invalidate()
          manager?.stopUpdatingLocation()
       
    }
    
    func startTimer(){
        durationLabel.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    @objc func updateCounter(){
        counter += 1
        durationLabel.text = counter.formatTimeDurationToString()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
   
    @IBAction func stopWalkingPressed(_ sender: Any) {
        endWalk()
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        if timer.isValid {
            pauseWalk()
        }else {
            startWalk()
        }
    }
    
    @IBAction func startWalkingPressed(_ sender: Any) {
        startWalk()
    }
    
    @IBAction func locationCenterButtonPressed(_ sender: Any) {
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first //first item in locations array
        } else if let location = locations.last {
            walkDistance += lastLocation.distance(from: location)
            let newLocation = Location(latitude: Double(lastLocation.coordinate.latitude), longitude: Double(lastLocation.coordinate.longitude))
            coordinateLocations.insert(newLocation, at: 0) //similar to stack implementation
            distanceLabel.text = "Distance: \(String(format: "%.2f", walkDistance))m"
        }
        lastLocation = locations.last
    }
    
}
