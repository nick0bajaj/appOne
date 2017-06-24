//
//  postTripViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/18/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

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
    
    @IBAction func isRider(_ sender: Any) {
        riderButton.titleLabel!.font = UIFont(name: "Futura-Bold", size: 17.0)
        riderButton.setTitle("Rider", for: UIControlState.selected)
        driverButton.titleLabel!.font = UIFont(name: "Futura-Medium", size: 17.0)
        driverButton.setTitle("Driver", for: UIControlState.normal)
    }
    
    @IBAction func isDriver(_ sender: Any) {
        driverButton.titleLabel!.font = UIFont(name: "Futura-Bold", size: 17.0)
        driverButton.setTitle("Driver", for: UIControlState.selected)
        riderButton.titleLabel!.font = UIFont(name: "Futura-Medium", size: 17.0)
        riderButton.setTitle("Rider", for: UIControlState.normal)
    }
    
    @IBAction func createTrip(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
