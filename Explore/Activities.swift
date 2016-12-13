//
//  Activities.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import UIKit

class Activities {
    
    private let nameKey = "name"
    private let activityTypeKey = "activity_type_name"
    private let urlKey = "url"
    private let descriptionKey = "description"
    private let thumbnailImageKey = "thumbnail"
    
    let name: String
    let activityType: String
    let url: String
    let description: String
    let thumbnailImage: String
    var activityImage: UIImage?
    
    init(name: String, activityType: String, url: String, description: String, thumbnailImage: String, activityImage: UIImage? = nil) {
        self.name = name
        self.activityType = activityType
        self.url = url
        self.description = description
        self.thumbnailImage = thumbnailImage
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[nameKey] as? String,
            let description = dictionary[descriptionKey] as? String else { return nil }
        
        self.name = name
        self.activityType = dictionary[activityTypeKey] as? String ?? "NO ACTIVITY TYPE"
        self.url = dictionary[urlKey] as? String ?? "NO URL"
        self.description = description
        self.thumbnailImage = dictionary[thumbnailImageKey] as? String ?? "NO"
        
//        if thumbnailImage != "NO" {
//            print("In thumbnail image")
//            ImageController.image(forURL: thumbnailImage, completion: { (image) in
//                self.activityImage = image
//                print("WE HAVE LIFTOFF")
//            })
//        } else {
//            self.activityImage = nil
//            return
//        }
    }
}
