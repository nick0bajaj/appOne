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
import FirebaseFirestore

class postTripViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    var departureAddressClicked = false
    
    @IBOutlet weak var departureAddressButton: UIButton!
    
    @IBOutlet weak var destinationAddressButton: UIButton!
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func isValidAddress(button: UIButton) -> Bool{
        switch button.currentTitle! {
        case "":
            self.alertTheUser(title: "Problem with Depature Address", message: "Depature address cannot be blank")
            return false
        case "Enter Depature Address Here":
            self.alertTheUser(title: "Problem with Depature Address", message: "Must enter valid depature address")
            return false
        case "Enter Destination Address Here":
            self.alertTheUser(title: "Problem with Depature Address", message: "Must enter valid depature address")
            return false
        default:
            return true
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place address: \(String(describing: place.formattedAddress))")
//        print("Place attributions: \(String(describing: place.attributions))")
        viewController.dismiss(animated: true, completion: nil)
        if(departureAddressClicked){
            departureAddressButton.setTitle(place.formattedAddress, for: .normal)
            departureAddressClicked = false
        } else {
            destinationAddressButton.setTitle(place.formattedAddress, for: .normal)
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
    
    @IBOutlet weak var month: UITextField!
    
    @IBOutlet weak var day: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var hasCar: UISwitch!
    
    @IBOutlet weak var extraInfo: UITextField!
    
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
        if(isValidAddress(button: destinationAddressButton) && isValidAddress(button: departureAddressButton)){
            let trip : [String: AnyObject] =
                [Constants.MONTH : month.text! as AnyObject,
                 Constants.DAY : day.text! as AnyObject,
                 Constants.YEAR : year.text! as AnyObject,
                 Constants.HASCAR : hasCar.isOn as AnyObject,
                 Constants.EXTRAINFO : extraInfo.text! as AnyObject,
                 Constants.DEPARTUREADDRESS : departureAddressButton.currentTitle! as AnyObject,
                 Constants.DESTINATIONADDRESS : destinationAddressButton.currentTitle! as AnyObject]
            let dbp = DBProvider()
            dbp.uploadTrip(trip: trip)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
