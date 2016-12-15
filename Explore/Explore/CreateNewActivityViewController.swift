//
//  CreateNewActivityViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class CreateNewActivityViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var seasonTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
        // Create CommunityActivity based on what is in the view
        
            // need Name, photoData, locationString, locationLat, locationLon, description, seasonString
        
        // Clear TextFields
        // Pop
        
        let _ = navigationController?.popViewController(animated: true)
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
