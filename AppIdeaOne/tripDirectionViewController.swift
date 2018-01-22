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
    
    private let tripDirectionSegue = "tripDirectionSegue"

    @IBAction func goingToBerkeley(_ sender: Any) {
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    @IBAction func leavingBerkeley(_ sender: Any) {
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
}
