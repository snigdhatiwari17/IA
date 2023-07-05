
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
    
    override func viewDidLoad() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.fitness
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
}

