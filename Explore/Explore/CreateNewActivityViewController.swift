//
//  CreateNewActivityViewController.swift
//  Explore
//
//  Created by Nathan Hopkins on 12/6/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit
import MapKit

class CreateNewActivityViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var pinOnMapButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var imageBeingUsed: UIImageView!
    
    
    
    
    var pinLocationLat: Double? {
        didSet{
            print("Added locationLat to CreateNewActivityController: \(pinLocationLat)")
        }
    }
    var pinLocationLon: Double? {
        didSet{
            print("Added locationLon to CreateNewActivityController: \(pinLocationLon)")
        }
    }
    
    var seasonTextFieldTapped = false
    var imageHasBeenSelected = false
    
    //============================
    //  Mark: - LifeCycle
    //============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.locationTextField.delegate = self
        self.seasonTextField.delegate = self
        self.descriptionTextView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        ///////
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //////
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if pinLocationLon != nil && pinLocationLat != nil {
            pinOnMapButton.setTitle("Press to re-pin location", for: .normal)
            
        } else {
            pinOnMapButton.setTitle("Pin location on map", for: .normal)
        }
    }
    
    //    override func viewDidDisappear(_ animated: Bool) {
    //        pinLocationLon = nil
    //        pinLocationLat = nil
    //    }
    
    //============================
    //  Mark: - Custom Functions
    //============================
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, seasonTextFieldTapped == true {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //============================
    //  Mark: - Actions
    //============================
    
    @IBAction func unwindToCreateNewActivity(segue: UIStoryboardSegue) {}
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        ///
        /// need to create/save object
        ///
        /// Done toolbar
        ///
        
        
        if nameTextField.text == "" || locationTextField.text == "" || descriptionTextView.text == "" || descriptionTextView.text == "Description: (Include Instructions if needed)" || seasonTextField.text == "" || pinLocationLat == nil || pinLocationLon == nil || imageHasBeenSelected == false {
            let notFinishedAlert = UIAlertController(title: "Missing data", message: "Please fill in all the provided text fields", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            notFinishedAlert.addAction(alertAction)
            present(notFinishedAlert, animated: true, completion: {
                // Clears TextFields and values:
                //                self.nameTextField.text = nil
                //                self.locationTextField.text = nil
                //                self.descriptionTextView.text = nil
                //                self.seasonTextField.text = nil
                //                self.pinLocationLat = nil
                //                self.pinLocationLon = nil
                //                self.pinOnMapButton.setTitle("Press to pin location", for: .normal)
                return
            })
        } else {
            guard let name = nameTextField.text,
                    let location = locationTextField.text,
                    let locationLat = pinLocationLat,
                    let locationLon = pinLocationLon,
                    let description = descriptionTextView.text,
                    let season = seasonTextField.text,
                let image = imageBeingUsed.image else { return }
            
            CommunityActivityController.shared.createNewCommunityActivityAndSaveToCloudKit(name: name, location: location, locationLat: Float(locationLat), locationLon: Float(locationLon), description: description, season: season, image: image)
            
        }
        
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPhotoButtonTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    //=============================
    //  Mark: - Delegate Functions
    //=============================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description: (Include Instructions if needed)" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description: (Include Instructions if needed)"
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == seasonTextField  {
            seasonTextFieldTapped = true
        } else {
            seasonTextFieldTapped = false
        }
        
        return true
    }
    
    // Image Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectPhotoButton.setTitle("Tap here to change image being used", for: .normal)
            imageBeingUsed.image = image
            imageHasBeenSelected = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPinOnMap" {
            if let destinationVC = segue.destination as? PinOnMapViewController {
                if pinLocationLon != nil && pinLocationLat != nil {
                    destinationVC.pinLocationLon = self.pinLocationLon
                    destinationVC.pinLocationLat = self.pinLocationLat
                }
            }
        }
    }
}
