//
//  LocalPlacesController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/8/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class LocalPlacesController {
    
    static var arrayOfAPILocalActivities: [APILocalPlaces] = []
    
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
            
            //guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] else { print("Error serializing JSON.\n Response: \(responseDataString)"); return }
            
            guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [[String: Any]]] else { print("Error serializing JSON.\n Response: \(responseDataString)"); return }

            guard let arrayOfPlaces = responseDictionary["places"] else { return }
            
            for place in arrayOfPlaces {
                guard let tempPlace = APILocalPlaces(dictionary: place) else { return }
                arrayOfAPILocalActivities.append(tempPlace)
            }
        }
    }
}







