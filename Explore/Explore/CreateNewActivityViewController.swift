//
//  CreateNewActivityViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class CreateNewActivityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
        // Do Stuff
        // Clear TextFields
        // Pop
        
        navigationController?.popViewController(animated: true)
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
