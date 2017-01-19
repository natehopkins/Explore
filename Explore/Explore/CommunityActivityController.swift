//
//  CommunityActivityController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/14/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class CommunityActivityController {
    
    let cloudKitManager: CloudKitManager
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    static let shared = CommunityActivityController()
    
    let arrayOfCommunityActivities: [CommunityActivity] = []
    
    // function to pull from cloudkit
    
    func createCommunityActivityFrom(record: CKRecord, completion: @escaping () -> Void) {
    
    }
    
    func saveToCloudKitWith(activity: CommunityActivity, completion: @escaping () -> Void) {
        let activityRecord = CKRecord(communityActivity: activity)
        
        cloudKitManager.saveRecord(activityRecord) { (record, error) in
            
            if error != nil {
                print("Error saving the activityRecord to CloudKit: \(error?.localizedDescription)")
            }
        }
    }
    // function to save to cloudKit
    
    func createNewCommunityActivityAndSaveToCloudKit(name: String, location: String, locationLat: Float, locationLon: Float, description: String, season: String, image: UIImage) {
        guard let image = UIImagePNGRepresentation(image) else { return }
        
        let communityActivity = CommunityActivity(name: name, photoData: image, location: location, locationLat: locationLat, locationLon: locationLon, description: description, season: season)
        let communityActivityRecord = CKRecord(communityActivity: communityActivity)
        
        cloudKitManager.saveRecord(communityActivityRecord) { (record, error) in
            if let error = error {
                print("Error saving the record to cloudkit:")
                print(error.localizedDescription)
            }
            if error == nil {
                print("Succesfully saved post to cloudkit")
            }
        }
    }
}
