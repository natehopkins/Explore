//
//  Activities.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class Activities {
    let name: String
    let activityType: String
    let url: String
    let description: String
    let thumbnailImage: String
    
    init(name: String, activityType: String, url: String, description: String, thumbnailImage: String) {
        self.name = name
        self.activityType = activityType
        self.url = url
        self.description = description
        self.thumbnailImage = thumbnailImage
    }
}
