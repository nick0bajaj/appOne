//
//  myPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/13/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class myPageViewController: UIViewController {
    
    let editPageSegue : String = "editPageSegue"
    
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBAction func editProfileButton(_ sender: Any) {
        performSegue(withIdentifier: self.editPageSegue, sender: <#T##Any?#>)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
