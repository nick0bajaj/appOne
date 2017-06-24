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
    let db = DBProvider()
    
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBAction func editProfileButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.editPageSegue, sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNameLabel.text = "in view did load"
        let firstName = db.retrieveInfo(Location: Constants.FIRSTNAME)
        let lastName = db.retrieveInfo(Location: Constants.LASTNAME)
        myNameLabel.text = firstName + " " + lastName
        aboutMeLabel.text = db.retrieveInfo(Location: Constants.ABOUTME)
        emailAddressLabel.text = db.retrieveInfo(Location: Constants.EMAIL)
        phoneNumberLabel.text = db.retrieveInfo(Location: Constants.PHONENUMBER)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : editPageViewController = segue.destination as! editPageViewController
        destVC.backSegue = "editPageSegue"
    }

}
