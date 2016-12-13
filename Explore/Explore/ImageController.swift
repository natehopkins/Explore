//
//  ImageController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/9/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else { fatalError("Image URL optional is nil") }
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            guard let data = data, let image = UIImage(data: data) else { print("Error fetching image data"); DispatchQueue.main.async { completion(nil) }
                return
            }
            
            DispatchQueue.main.async { print("Returned the image"); completion(image) }
        }
         print("Error performing image request")
    }
}
