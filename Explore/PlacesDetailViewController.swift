//
//  PlacesDetailViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/7/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class PlacesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var place: APILocalPlaces?
    var activities: [Activities]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionHeaderHeight = 60
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = UIColor.clear
        
        self.tableView.addSubview(headerView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfActivities = activities?.count else { return 0 }
        return numberOfActivities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as? ActivitiesTableViewCell else { return UITableViewCell() }
        guard let activity = activities?[indexPath.row], let place = place else { return UITableViewCell() }
        
        cell.updateWith(place: place, activity: activity)
        
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "activityToDetail" {
            if let destinationVC = segue.destination as? PlacesActivityDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    guard let place = place else { return }
                    guard let activity = activities?[indexPath.row] else { return }
                    
                    destinationVC.place = place
                    destinationVC.activity = activity
                }
            }
        }
    }
}
