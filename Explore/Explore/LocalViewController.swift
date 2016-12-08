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
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        createCollectionViewCellLayout()
        
        loadPlaces()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadPlaces() {
        
        locationManager.requestLocation()
        
        guard let latitude = locationManager.location?.coordinate.latitude else { print("Error with lat"); return }
        guard let longitude = locationManager.location?.coordinate.longitude else { print("error with lon"); return }
        
        
        LocalPlacesController.fetchStuffWith(lat: Float(latitude), lon: Float(longitude))
    }
    // Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Do stuff
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: \(error.localizedDescription)")
    }
    //

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath)
        
        cell.layer.backgroundColor = UIColor.red.cgColor
        
        return cell
    }
    
    func createCollectionViewCellLayout() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        layout.sectionInset = UIEdgeInsets(top: 65, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 2) - 20)//172 165
        
        collectionView.backgroundColor = UIColor.clear
        
        
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
