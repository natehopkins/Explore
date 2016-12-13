//
//  PlacesCollectionViewCell.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/8/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithPlace(place: APILocalPlaces) {
        // Map Stuff
        
        self.layer.cornerRadius = self.frame.height / 2
        
        //guard let locationLat = place.locationLat, let locationLon = place.locationLon else { return }
        
//        guard let locationLat = CLLocationDegrees(exactly: place.locationLat), let locationLon = CLLocationDegrees(exactly: place.locationLon) else { return }
        
//        let center = CLLocationCoordinate2D(latitude: locationLat , longitude: locationLon)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.0059, 0.0059))
        
//        self.mapView.setRegion(region, animated: true)
        
        imageView.image = place.placeImage
        
        // Label stuff
        self.placeNameLabel.text = place.name
        self.backgroundColor = .red
    }
}
