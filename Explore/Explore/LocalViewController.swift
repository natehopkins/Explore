//
//  LocalViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import CoreLocation

class LocalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Notification
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        locationManager.delegate = self
    
        self.navigationController?.navigationBar.isHidden = true
        createCollectionViewCellLayout()
        
        
        self.loadPlaces(completion: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData1), name: NSNotification.Name.init(rawValue: "testKey"), object: nil)
        
    }
    
    func reloadData1() {
        collectionView.reloadData()
        print("notification received")
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadPlaces(completion: @escaping ()-> Void) {
        
        locationManager.requestLocation()
        
        guard let latitude = locationManager.location?.coordinate.latitude else { print("Error with lat"); return }
        guard let longitude = locationManager.location?.coordinate.longitude else { print("error with lon"); return }
    
        print("\(latitude)")
        print("\(longitude)")
        
        
        LocalPlacesController.fetchStuffWith(lat: Float(latitude), lon: Float(longitude))
    }
    
    //============================
    //  Mark: - Delegate Methods
    //============================
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Do stuff
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: \(error.localizedDescription)")
    }
    
    
    //============================
    //  Mark: - DataSource functions
    //============================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(LocalPlacesController.arrayOfAPILocalActivities.count)
        return LocalPlacesController.arrayOfAPILocalActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath) as? PlacesCollectionViewCell else { return UICollectionViewCell() }
        
        let place = LocalPlacesController.arrayOfAPILocalActivities[indexPath.row]
        
        cell.updateWithPlace(place: place)
        
        return cell
    }
    
    func createCollectionViewCellLayout() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        layout.sectionInset = UIEdgeInsets(top: 65, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 2) - 20)//172 165
        
        collectionView.backgroundColor = UIColor.clear
    }
    
    //============================
    //  Mark: - Navigation
    //============================
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPlacesActivities", sender: self)
    }
    
    
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "toPlacesActivities" {
            if let destinationVC = segue.destination as? PlacesDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    let place = LocalPlacesController.arrayOfAPILocalActivities[indexPath.row]
                    let placeActivities = place.arrayOfActivities
                    
                    destinationVC.place = place
                    destinationVC.activities = placeActivities
                }
            }
        }
        
     }
 
    
}
