//
//  LocalViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        createCollectionViewCellLayout()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath)
        
        cell.layer.backgroundColor = UIColor.red.cgColor
        
        return cell
    }
    
    func createCollectionViewCellLayout() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        layout.sectionInset = UIEdgeInsets(top: 65, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 2) - 20)//172 165
        
        collectionView.backgroundColor = UIColor.clear
        
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
