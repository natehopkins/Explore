//
//  PinOnMapViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/14/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class PinOnMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.locationManager.requestLocation()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pinButtonTapped(_ sender: Any) {
        // grab lat/lon from pin and perform segue
        
        ///////////
        /////////// Next thing to do is to grab the add a pin and enable user to move it.
        ///////////
    }
    
    //=============================
    //  Mark: - Delegate Functions
    //=============================
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        // Update Map
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapView.showsUserLocation = true
        mapView.mapType = .hybrid
        mapView.showsCompass = true
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("locationManager failed with error: \(error.localizedDescription)")
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
