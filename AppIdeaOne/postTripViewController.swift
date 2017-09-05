//
//  postTripViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/18/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class postTripViewController: UIViewController {

    @IBOutlet weak var pickUp: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var month: UITextField!
    
    @IBOutlet weak var day: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var canDrive: UISwitch!
    
    @IBOutlet weak var extraInfo: UITextField!
    
    @IBOutlet weak var riderButton: UIButton!
    
    @IBOutlet weak var driverButton: UIButton!
    
    var isRider = "True"
    
    var userRef: DatabaseReference {
        
        return Database.database().reference().child(Constants.ID)
        
    }
    
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
    
    @IBAction func createTrip(_ sender: Any) {
        getTrips()
    }
    
    private func getTrips() {
        print("Trips Retrieved")
        var drivable = "False"
        if (self.canDrive.isOn) {
            drivable = "True"
        }
        DBProvider.Instance.uploadTrips(Location: Constants.MONTH, Value: self.month.text!)
        DBProvider.Instance.uploadTrips(Location: Constants.DAY, Value: self.day.text!)
        DBProvider.Instance.uploadTrips(Location: Constants.YEAR, Value: self.year.text!)
        DBProvider.Instance.uploadTrips(Location: Constants.DRIVABLE, Value: drivable)
        DBProvider.Instance.uploadTrips(Location: Constants.ISRIDER, Value: self.isRider)
        DBProvider.Instance.uploadTrips(Location: Constants.EXTRAINFO, Value: self.extraInfo.text!)
        DBProvider.Instance.uploadTrips(Location: Constants.FROMADDRESS, Value: self.pickUp.text!)
        DBProvider.Instance.uploadTrips(Location: Constants.DESTINATIONADDRESS, Value: self.destination.text!)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
