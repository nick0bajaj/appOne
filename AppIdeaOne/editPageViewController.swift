//
//  editPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/23/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

class editPageViewController: UIViewController {
        
    let profileCreator = setUpProfile()
    
    let db = DBProvider()
    
    
    @IBAction func profileButton(_ sender: Any) {
    }
    
    var backSegue = "profileCreatedSegue"

    @IBOutlet weak var myName: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var aboutMeTextField: UITextField!
    
    @IBAction func completedButton(_ sender: Any) {
        db.uploadInfo(Location: Constants.PHONENUMBER, Value: phoneNumberTextField.text!)
        db.uploadInfo(Location: Constants.ABOUTME, Value: aboutMeTextField.text!)
        self.performSegue(withIdentifier: self.backSegue, sender: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.backSegue, sender: nil)
    }

    
    @IBAction func editProfilePicture(_ sender: Any) {
        //profileCreator.swapPhoto(profilePicture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstName = db.retrieveInfo(Location: Constants.FIRSTNAME)
        let lastName = db.retrieveInfo(Location: Constants.LASTNAME)
        myName.text = firstName + " " + lastName
        emailTextField.text = db.retrieveInfo(Location: Constants.EMAIL)
        phoneNumberTextField.text = db.retrieveInfo(Location: Constants.PHONENUMBER)
        aboutMeTextField.text = db.retrieveInfo(Location: Constants.ABOUTME)
        emailTextField.isUserInteractionEnabled = false
    }
}
