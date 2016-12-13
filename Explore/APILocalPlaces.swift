//
//  APILocalActivites.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class APILocalPlaces {
    
    private let nameKey = "name"
    private let cityKey = "city"
    private let stateKey = "state"
    private let countryKey = "country"
    private let locationLatKey = "lat"
    private let locationLonKey = "lon"
    private let arrayOfActivitiesKey = "activities"
    
    let name: String
    let city: String
    let state: String
    let country: String
    let locationLat: Float
    let locationLon: Float
    var arrayOfActivities: [Activities]
    
    var placeImage: UIImage? = nil
    
    init(name: String, city: String, state: String, country: String, locationLat: Float, locationLon: Float, arrayOfActivities: [Activities]) {
        
        self.name = name
        self.city = city
        self.state = state
        self.country = country
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.arrayOfActivities = arrayOfActivities
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[nameKey] as? String,
            let locationLat = dictionary[locationLatKey] as? Float,
            let locationLon = dictionary[locationLonKey] as? Float,
            let activityArray = dictionary[arrayOfActivitiesKey] as? [[String: Any]] else { return nil }
        
        self.name = name
        self.city = dictionary[cityKey] as? String ?? "No city info avaliable"
        self.state = dictionary[stateKey] as? String ?? "No state info avaliable"
        self.country = dictionary[countryKey] as? String ?? "No country info avaliable"
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.arrayOfActivities = []
        
        if activityArray.count > 0 {
            for activity in activityArray {
                guard let initializedActivity = Activities(dictionary: activity) else { return }
                arrayOfActivities.append(initializedActivity)
            }
        } else { print("Doesn't have activities"); return nil }
    }
}
