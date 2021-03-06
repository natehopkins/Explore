//
//  PlacesActivityDetailViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class PlacesActivityDetailViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var place: APILocalPlaces?
    var activity: Activities?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContainer" {
            if let destinationVC = segue.destination as? DetailTableViewController {
                
                guard let place = place else { return }
                guard let activity = activity else { return }
                
                destinationVC.place = place
                destinationVC.activity = activity
            }
        }
    }
}
