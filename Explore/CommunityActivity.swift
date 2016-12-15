//
//  CommunityActivities.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class CommunityActivity {
    
    //============================
    //  Mark: - Properties
    //============================
    
    static let recordTypeKey = "CommunityActivity"
    static let photoDataKey = "photoData"
    static let nameKey = "name"
    static let imagesKey = "image"
    static let locationKey = "location"
    static let locationLatKey = "locationLat"
    static let locationLonKey = "locationLon"
    static let descriptionKey = "description"
    static let seasonKey = "season"
    
    let name: String
    let location: String
    let locationLat: Float
    let locationLon: Float
    let description: String
    let season: String
    var photoData: Data?
    
    // Computed Properties
    
    var recordType: String {
        return CommunityActivity.recordTypeKey
    }
    
    // Returns an image based on photoData
    var photo: UIImage? {
        guard let photoData = self.photoData else { print("photoData is nil"); return nil }
        return UIImage(data: photoData)
    }
    
    // returns a temporaryPhotoURL
    var temporaryPhotoURL: URL {
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectory)
        guard let fileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)?.appendingPathExtension("jpeg") else { print("Not a working URL"); return URL(string: "Not a working URL")! }
        
        try? photoData?.write(to: fileURL)
        return fileURL
    }
    
    //============================
    //  Mark: - Initializers
    //============================
    
    init(name: String, photoData: Data, location: String, locationLat: Float, locationLon: Float, description: String, season: String) {
        self.name = name
        self.photoData = photoData
        self.location = location
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.description = description
        self.season = season
    }
    
    convenience required init?(record: CKRecord) {
        guard let name = record.object(forKey: CommunityActivity.nameKey) as? String,
            let photoAsset = record.object(forKey: CommunityActivity.photoDataKey) as? CKAsset,
            let location = record.object(forKey: CommunityActivity.locationKey) as? String,
            let locationLat = record.object(forKey: CommunityActivity.locationLatKey) as? Float,
            let locationLon = record.object(forKey: CommunityActivity.locationLonKey) as? Float,
            let description = record.object(forKey: CommunityActivity.descriptionKey) as? String,
            let season = record.object(forKey: CommunityActivity.seasonKey) as? String else { return nil }
        guard let photoData = try? Data(contentsOf: photoAsset.fileURL) else { print("No photo data in CKRecord"); return nil }
        
        self.init(name: name, photoData: photoData, location: location, locationLat: locationLat, locationLon: locationLon, description: description, season: season)
    }
}

extension CKRecord {
    convenience init(communityActivity: CommunityActivity) {
        
        let recordID = CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: CommunityActivity.recordTypeKey, recordID: recordID)
        
        self.setValue(CKAsset(fileURL: communityActivity.temporaryPhotoURL), forKey: CommunityActivity.photoDataKey)
        self.setValue(communityActivity.name, forKey: CommunityActivity.nameKey)
        self.setValue(communityActivity.location, forKey: CommunityActivity.locationKey)
        self.setValue(communityActivity.locationLat, forKey: CommunityActivity.locationLatKey)
        self.setValue(communityActivity.locationLon, forKey: CommunityActivity.locationLonKey)
        self.setValue(communityActivity.description, forKey: CommunityActivity.descriptionKey)
        self.setValue(communityActivity.season, forKey: CommunityActivity.seasonKey)
    }
}









