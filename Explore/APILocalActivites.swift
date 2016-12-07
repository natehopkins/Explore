//
//  APILocalActivites.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class APILocalActivites {
    let name: String
    let city: String
    let state: String
    let country: String
    let locationLat: Float
    let locationLon: Float
    let arrayOfActivities: [Activities]
    
    init(name: String, city: String, state: String, country: String, locationLat: Float, locationLon: Float, arrayOfActivities: [Activities]) {
        self.name = name
        self.city = city
        self.state = state
        self.country = country
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.arrayOfActivities = arrayOfActivities
    }
}
