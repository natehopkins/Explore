//
//  LocalPlacesController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/8/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import MapKit

class LocalPlacesController {
    
    static var arrayOfAPILocalActivities: [APILocalPlaces] = [] {
        didSet {
            let nc = NotificationCenter.default
            let test = NSNotification.Name.init(rawValue: "testKey")
            nc.post(name: test, object: self)
        }
    }
    
    static let apiKey = "7bRVMLnHXUmshjzAexlLTHym9Lfkp1zrOKujsn7ddTd1VM5CvZ"
    static let baseURL = URL(string: "https://trailapi-trailapi.p.mashape.com/")
    
    
    static func fetchStuffWith(lat: Float, lon: Float) {
        
        //        var locationSearchURL = baseURL?.appendingPathComponent(String(lat))
        //        locationSearchURL = locationSearchURL?.appendingPathComponent(String(lon))
        
        
        let headersDictionary = ["X-Mashape-Key": apiKey, "Accept": "text/plain"]
        
        let keyParameter = ["lat": String(lat), "lon": String(lon), "radius": "10"]
        guard let url = baseURL else { return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: keyParameter, headers: headersDictionary, body: nil) { (data, error) in
            
            if error != nil {
                print("Error in LocalPlacesController: \(error?.localizedDescription)" ); return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { print("No data returned from network request"); return }
            
            guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [[String: Any]]] else { print("Error serializing JSON.\n Response: \(responseDataString)"); return }
            
            guard let arrayOfPlaces = responseDictionary["places"] else { return }
            
            var tempArray: [APILocalPlaces] = []
            
            // Looping through arrayOfPlaces array of dictionaries
            
            let group = DispatchGroup()
            var groupCount = 0
            for dict in arrayOfPlaces {
                groupCount += 1
                //                print(groupCount)
                group.enter()
                
                // Creating APILocalPlaces object with dictionary
                // CreatePlaceWith function called
                createPlaceWith(placesDict: dict, completion: { (place) in
                    guard let place = place else { group.leave(); return }
                    
                    tempArray.append(place)
                    
                    groupCount -= 1
                    //                    print(groupCount)
                    group.leave()
                })
            }
            
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                let group2 = DispatchGroup()
                group2.enter()
                // Get thumbnail here
                
                for place in tempArray {
                    
                    let activityArray = place.arrayOfActivities
                    
                    for activity in activityArray {
                        createThumbnailImageForActivityWith(activity: activity, completion: { (image) in
                            activity.activityImage = image
                        })
                    }
                }
                group2.leave()
                
                group2.notify(queue: DispatchQueue.main, execute: {
                    
                    arrayOfAPILocalActivities = tempArray
                    print("appended temp array")
                })
                
                
                
                // make a new group
                
                
                
                // set arrayOfAPILocalActivities in the newGroup.notify instead of this one.
            })
        }
    }
    
    static func createThumbnailImageForActivityWith(activity: Activities, completion: @escaping (UIImage?) -> Void) {
        ImageController.image(forURL: activity.thumbnailImage, completion: { (image) in
            completion(activity.activityImage)
        })
    }
    
    static var debugCount = 0
    
    static func createPlaceWith(placesDict: [String: Any], completion: @escaping (APILocalPlaces?) -> Void){
        
        // Assigns newly created 'Place' to "tempPlace"
        guard let tempPlace = APILocalPlaces(dictionary: placesDict) else { self.debugCount += 1; print("Error creating APILocalPlace: DebugCount \(self.debugCount)"); completion(nil); return }
        // Create snapshot for "tempPlace"'s coordinates and getting back a UIImage
        createSnapshotForPlace(place: tempPlace) { (tempImage) in
            
            // Set tempPlace.placeImage equal to tempImage (UIImage) that was handed back from the snapshot
            tempPlace.placeImage = tempImage
            
            // Pass the temp place back to the completion
            completion(tempPlace)
        }
    }
    
    
    static func createSnapshotForPlace(place: APILocalPlaces, completion: @escaping (UIImage?) -> Void) {
        // Get lat/long
        guard let locationLat = CLLocationDegrees(exactly: place.locationLat),
            let locationLon = CLLocationDegrees(exactly: place.locationLon) else { print("Error with lat/lon in snapshot"); return }
        // Make region
        let center = CLLocationCoordinate2D(latitude: locationLat, longitude: locationLon)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.0059, 0.0059))
        
        // Make snapshot options
        let options = MKMapSnapshotOptions()
        options.region = region
        options.mapType = .hybrid
        options.size = CGSize(width: 300, height: 300)
        //options scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        // Run snapshotter
        
        // Return image from snapshot
        var tempScreenshot: UIImage? = nil
        
        snapshotter.start { (snapshot, error) in
            if error != nil {
                print("Error in the snapshotter: \(error?.localizedDescription)")
            }
            guard let snapshot = snapshot else { print("Error with snapshot"); completion(nil); return }
            tempScreenshot = snapshot.image
            
            // Once you have the image you are running a completion handing it back
            completion(tempScreenshot)
        }
    }
}







