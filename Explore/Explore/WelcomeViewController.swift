//
//  WelcomeViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //============================
    //  Mark: - Outlets
    //============================
    
    
    @IBOutlet weak var welcomeLabelView: UIView!
    @IBOutlet weak var localActivitiesView: UIView!
    @IBOutlet weak var communityActivitiesView: UIView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(LocalPlacesController.arrayOfAPILocalActivities.count)
        
        // Hides navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        // Location Services
        
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    //============================
    //  Mark: - Functions
    //============================
    
    func setupLabelViewProperties() {
        welcomeLabelView.layer.cornerRadius = 20
        localActivitiesView.layer.cornerRadius = 20
        communityActivitiesView.layer.cornerRadius = 20
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


extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}
