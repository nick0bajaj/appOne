//
//  tripDirectionViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 1/21/18.
//  Copyright © 2018 NickBajaj. All rights reserved.
//

import UIKit

class tripDirectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var buttonPressed : Bool = false
    
    private let tripDirectionSegue = "tripDirectionSegue"

    @IBAction func goingToBerkeley(_ sender: Any) {
        buttonPressed = true
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    @IBAction func leavingBerkeley(_ sender: Any) {
        buttonPressed = false
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var postTripVC = segue.destination as! postTripViewController
        postTripVC.direction = buttonPressed
    }
}
