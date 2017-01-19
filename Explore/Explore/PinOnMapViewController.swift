//
//  PinOnMapViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/14/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class PinOnMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pinLocationLat: Double? {
        didSet {
            print("pinLocationLat was set")
        }
    }
    var pinLocationLon: Double? {
        didSet{
            print("pinLocationLon was set")
        }
    }
    
    let locationManager = CLLocationManager()
    
    //============================
    //  Mark: - LifeCyle
    //============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.locationManager.delegate = self
        self.mapView.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        self.locationManager.requestLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if pinLocationLat != nil && pinLocationLon != nil {
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = CLLocationDegrees(exactly: pinLocationLat!)!//Force unwrapped because checked if not nil
            annotation.coordinate.longitude = CLLocationDegrees(exactly: pinLocationLon!)!//Force unwrapped because checked if not nil
            
            mapView.addAnnotation(annotation)
        }
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Number of annotations:")
        print(mapView.annotations.count)
        
    }
    
    //============================
    //  Mark: - Actions
    //============================
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
        let locationCGPoint = sender.location(in: self.mapView)
        
        let locationCoordinate = self.mapView.convert(locationCGPoint, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.title = "location"
        annotation.coordinate = locationCoordinate
        
        mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
        
        self.pinLocationLon = annotation.coordinate.longitude
        self.pinLocationLat = annotation.coordinate.latitude
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
        
        if pinLocationLat != nil {
            performSegue(withIdentifier: "unwindToCreateNewActivity", sender: self)
        }
    }
    
    @IBAction func pinButtonTapped(_ sender: Any) {
        // grab lat/lon from pin and perform segue (does this in navigation)
        if self.pinLocationLat == nil || self.pinLocationLon == nil {
            let noPinAlert = UIAlertController(title: "No pin found on map", message: "Please place pin on map or press the back button", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            noPinAlert.addAction(okayAction)
            
            present(noPinAlert, animated: true, completion: nil)
            return
        }
        self.performSegue(withIdentifier: "unwindToCreateNewActivity", sender: self)
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
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToCreateNewActivity" {
            if let destinationVC = segue.destination as? CreateNewActivityViewController {
                destinationVC.pinLocationLat = pinLocationLat
                destinationVC.pinLocationLon = pinLocationLon
            }
        }
        
    }
}

// May need later:

//  let isMyAnnotation = mapView.annotations.contains(where: {(($0.title ?? nil) ?? "") == "location"})

//        guard let title1 = mapView.annotations[0].title ?? "" else { print("No title on annotation 1"); return }
//        guard let title2 = mapView.annotations[1].title ?? "" else { print("No title on annotation 2"); return }
//
//        if title1 != ""{
//            pinLocationLat = mapView.annotations[0].coordinate.latitude
//            pinLocationLon = mapView.annotations[0].coordinate.longitude
//        } else if title2 != "" {
//            pinLocationLat = mapView.annotations[1].coordinate.latitude
//            pinLocationLon = mapView.annotations[1].coordinate.longitude
//        } else {
//            print("No annotation has a title")
//        }
