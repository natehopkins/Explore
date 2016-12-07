//
//  ActivitiesTableViewCell.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    
    override func awakeFromNib() {
        backgroundImage.image = #imageLiteral(resourceName: "Hiking")
        nameLabel.text = "Name of Activity Here"
        locationLabel.text = "Location of Activity Here"
    }
    
}
