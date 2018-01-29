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
    
    let toSearchVCSegue = "toSearchVCSegue"
    
    var tdEmmigrating : Bool = false
    
    var fromSearch : Bool = false
    
    private let tripDirectionSegue = "tripDirectionSegue"

    @IBAction func goingToBerkeley(_ sender: Any) {
        tdEmmigrating = false
        if (fromSearch){
            self.performSegue(withIdentifier: toSearchVCSegue, sender: nil)
        } else {
            self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
        }
    }
    
    @IBAction func leavingBerkeley(_ sender: Any) {
        tdEmmigrating = true
        if (fromSearch){
            self.performSegue(withIdentifier: toSearchVCSegue, sender: nil)
        } else {
            self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (fromSearch){
            fromSearch = false
            let searchTripVC = segue.destination as! searchTripViewController
            searchTripVC.emmigrating = tdEmmigrating
        } else {
            let postTripVC = segue.destination as! postTripViewController
            postTripVC.emmigrating = tdEmmigrating
        }
    }
}
