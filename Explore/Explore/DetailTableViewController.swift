//
//  DetailTableViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/12/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class DetailTableViewController: UITableViewController, MKMapViewDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var activityTypeTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
    var place: APILocalPlaces?
    var activity: Activities?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let place = place else { print("Failed HERE"); return }
        guard let activity = activity else { print("Failed here"); return }
        
        print("made it here")
        updateViewWith(place: place, activity: activity)
        
    }

    func updateViewWith(place: APILocalPlaces, activity: Activities) {
        
        nameTextField.text = place.name
        activityTypeTextField.text = activity.activityType
        descriptionTextField.text = activity.description
        linkTextField.text = activity.url
        // Update mapview
        guard let latitude = CLLocationDegrees(exactly: place.locationLat),
            let longitude = CLLocationDegrees(exactly: place.locationLon) else { return }
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 00.1, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(pin)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
