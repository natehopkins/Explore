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
    @IBOutlet weak var activityLabel: UILabel!

    
//    override func awakeFromNib() {
//        backgroundImage.image = #imageLiteral(resourceName: "Hiking")
//        nameLabel.text = "Name of Activity Here"
//        locationLabel.text = "Location of Activity Here"
//    }
    
    func updateWith(place: APILocalPlaces, activity: Activities) {
        nameLabel.text = activity.name
        activityLabel.text = activity.activityType
        locationLabel.text = "\(place.city), \(place.state)"
        backgroundImage.image = place.placeImage
//        if activity.activityImage != nil {
//            backgroundImage.image = activity.activityImage
//        } else {
//            backgroundImage.image = #imageLiteral(resourceName: "JennyLake")
//        }
    }
}
