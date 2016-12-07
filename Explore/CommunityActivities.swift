//
//  CommunityActivities.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import UIKit

class CommunityActivities {
    let name: String
    let images: [UIImage]
    let location: String
    let locationLat: Float
    let locationLon: Float
    let description: String
    let season: String
    
    init(name: String, images: [UIImage], location: String, locationLat: Float, locationLon: Float, description: String, season: String) {
        self.name = name
        self.images = images
        self.location = location
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.description = description
        self.season = season
    }
}
