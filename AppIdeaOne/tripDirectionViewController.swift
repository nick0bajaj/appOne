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
    
    var tdEmmigrating : Bool = false
    
    private let tripDirectionSegue = "tripDirectionSegue"

    @IBAction func goingToBerkeley(_ sender: Any) {
        tdEmmigrating = false
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    @IBAction func leavingBerkeley(_ sender: Any) {
        tdEmmigrating = true
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var postTripVC = segue.destination as! postTripViewController
        postTripVC.emmigrating = tdEmmigrating
    }
}
