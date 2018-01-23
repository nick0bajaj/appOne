//
//  searchTripViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 1/23/18.
//  Copyright © 2018 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth
import GooglePlaces
import MapKit
import CoreLocation
import FirebaseFirestore

class searchTripViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    let id = Auth.auth().currentUser?.uid
    
    private var addressAsPlace : GMSPlace?
    
    private let dbp = DBProvider()
    
    var emmigrating : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setMinimumDate()
    }
    
    @IBOutlet weak var addressButton: UIButton!

    @IBOutlet weak var departureDate: UIDatePicker!
    
    @IBAction func addressButton(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
        
    @IBAction func searchTrips(_ sender: Any) {

    }
        
    private func isValidPlace(addressPlace : GMSPlace?) -> Bool {
        if(addressPlace != nil){
            return true
        } else {
            self.alertTheUser(title: "Problem with Address", message: "Please enter valid address")
            return false
        }
    }
        
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
        
    private func isValidAddress(button: UIButton) -> Bool{
        switch button.currentTitle! {
        case "":
            self.alertTheUser(title: "Problem with Address", message: "Address cannot be blank")
            return false
        case nil:
            self.alertTheUser(title: "Problem with Address", message: "Must enter valid address")
            return false
        default:
            return true
        }
    }
        
    //sets current date as the minimum date on the Date Picker
    private func setMinimumDate(){
        let currDate = Date()
        departureDate.minimumDate = currDate
        print("Current date is\(currDate.description)")
    }
        
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        addressAsPlace = place
        addressButton.setTitle(place.formattedAddress, for: .normal)
    }
        
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
        
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
        
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
        
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
