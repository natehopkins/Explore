//
//  Activities.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class Activities {
    
    private let nameKey = "name"
    private let activityTypeKey = "activity_type_id"
    private let urlKey = "url"
    private let descriptionKey = "description"
    private let thumbnailImageKey = "thumbnail"
    
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
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[nameKey] as? String,
            let activityType = dictionary[activityTypeKey] as? String,
            let url = dictionary[urlKey] as? String,
            let description = dictionary[descriptionKey] as? String,
            let thumbnailImage = dictionary[thumbnailImageKey] as? String else { return nil }
        
        self.name = name
        self.activityType = activityType
        self.url = url
        self.description = description
        self.thumbnailImage = thumbnailImage

    }
}
