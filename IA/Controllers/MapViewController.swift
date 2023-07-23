
import AVFoundation
import CoreLocation
import Foundation
import MapKit
import UIKit

enum SettingsKeys: String {
    case accuracy
    case chimeOnLocationUpdate
    case showCrumbsBoundingArea
    case activity
}

class MapViewController: UIViewController, CLLocationManagerDelegate, AVAudioPlayerDelegate  {
    
    let locationManager = CLLocationManager()
    var audioPlayer: AVAudioPlayer?
    
    
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var recordButton: UIBarButtonItem!
    @IBOutlet weak var mapTrackingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        // MARK: - Location Mangement Properties
        var isMonitoringLocation = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.fitness
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
    }
    
    
    
    
    var chimeOnLocationUpdate = UserDefaults.standard.bool(forKey: SettingsKeys.chimeOnLocationUpdate.rawValue) {
        didSet {
            UserDefaults.standard.set(chimeOnLocationUpdate, forKey: SettingsKeys.chimeOnLocationUpdate.rawValue)
        }
    }
    
    @IBAction func startPressed(_ sender: Any) {
        locationManager.startUpdatingLocation()
        
        
    }
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Play a sound so it's easy to tell when a location update occurs while the app is in the background.
        if chimeOnLocationUpdate && !locations.isEmpty {
            setSessionActiveWithMixing(true) // Ducks the audio of other apps when playing the chime.
            playSound()
        }
        
        // Always process all of the provided locations. Don't assume the array only contains a single location.
        for location in locations {
            displayNewBreadcrumbOnMap(location)
        }
    }
    
    
    // MARK: - Audio Player
    
    private func setupAudioPlayer() {
        setSessionActiveWithMixing(false)
        if let sound = Bundle.main.url(forResource: "bells", withExtension: "aif") {
            audioPlayer = try! AVAudioPlayer(contentsOf: sound)
        }
    }
    
    private func tearDownAudioPlayer() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private func setSessionActiveWithMixing(_ duckIfOtherAudioIsPlaying: Bool) {
        try! AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        if AVAudioSession.sharedInstance().isOtherAudioPlaying && duckIfOtherAudioIsPlaying {
            try! AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers, .duckOthers])
        }
        
        try! AVAudioSession.sharedInstance().setActive(true)
    }
    
    private func playSound() {
        guard let audioPlayer else { return }
        if audioPlayer.isPlaying == false {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    
    // MARK: - Menus
    private var audioSettingsMenu: UIMenu {
        let menu = UIMenu(title: "Audio", options: .displayInline, children: [
            UIAction(title: "Play Sound on Location Updates",
                     state: chimeOnLocationUpdate ? .on : .off,
                     handler: { _ in
                         self.chimeOnLocationUpdate.toggle()
                         self.configureSettingsMenu()
                     })
        ])
        
        return menu
    }
    func configureSettingsMenu() {
        settingsButton.menu = UIMenu(title: "Settings", children: [
            mapSettingsMenu,
            audioSettingsMenu
        ])
    }
    private var mapSettingsMenu: UIMenu {
        let menu = UIMenu(title: "Map", options: .displayInline, children: [
            UIAction(title: "Display Breadcrumb Bounds",
                     state: showBreadcrumbBounds ? .on : .off,
                     handler: { _ in
                         self.showBreadcrumbBounds.toggle()
                         self.configureSettingsMenu()
                     })
        ])
        
        return menu
    }
}
