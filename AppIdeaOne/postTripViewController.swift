//
//  postTripViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/18/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth
import GooglePlaces
import MapKit
import CoreLocation

class postTripViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    var departureAddressClicked = false
    
    @IBOutlet weak var departureAddressText: UIButton!
    
    @IBOutlet weak var destinationAddressText: UIButton!
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        viewController.dismiss(animated: true, completion: nil)
        if(departureAddressClicked){
            departureAddressText.setTitle(place.name, for: .normal)
            departureAddressClicked = false
        } else {
            destinationAddressText.setTitle(place.name, for: .normal)
        }
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
    
//    func changeDepartureAddressText(String: text){
//        depart
//    }
    
    @IBOutlet weak var month: UITextField!
    
    @IBOutlet weak var day: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var canDrive: UISwitch!
    
    @IBOutlet weak var extraInfo: UITextField!
    
    @IBOutlet weak var riderButton: UIButton!
    
    @IBOutlet weak var driverButton: UIButton!
    
    var isRider = "True"
    
    @IBAction func isRider(_ sender: Any) {
        riderButton.titleLabel!.font = UIFont(name: "Futura-Bold", size: 17.0)
        riderButton.setTitle("Rider", for: UIControlState.selected)
        driverButton.titleLabel!.font = UIFont(name: "Futura-Medium", size: 17.0)
        driverButton.setTitle("Driver", for: UIControlState.normal)
        isRider = "True"
    }
    
    @IBAction func isDriver(_ sender: Any) {
        driverButton.titleLabel!.font = UIFont(name: "Futura-Bold", size: 17.0)
        driverButton.setTitle("Driver", for: UIControlState.selected)
        riderButton.titleLabel!.font = UIFont(name: "Futura-Medium", size: 17.0)
        riderButton.setTitle("Rider", for: UIControlState.normal)
        isRider = "False"
    }
    
    @IBAction func departureAddressButton(_ sender: UIButton) {
        departureAddressClicked = true
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func destinationAddressButton(_ sender: UIButton) {
        departureAddressClicked = false
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func createTrip(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
