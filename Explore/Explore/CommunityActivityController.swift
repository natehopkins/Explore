//
//  CommunityActivityController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/14/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import CloudKit

class CommunityActivityController {
    // function to pull from cloudkit
    
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    let cloudKitManager: CloudKitManager
    
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
    
}
