//
//  editPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/23/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import Firebase

class editPageViewController: UIViewController {
    
    let completedSegue = "profileCreatedSegue"
    
    let profileCreator = setUpProfile()
    

    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var aboutMeTextField: UITextField!
    

//    
//    @IBAction func backButton(_ sender: Any) {
//        if("user exists"){
//            self.performSegue(withIdentifier: <#T##String#>, sender: nil)
//        } else {
//            self.performSegue(withIdentifier: self.completedSegue, sender: nil)
//        }
//    }
//    
//    @IBAction func completedButton(_ sender: Any) {
//        profileCreator.uploadData(phoneNumber: phoneNumberTextField.text!, aboutMe: aboutMeTextField.text!)
//        self.performSegue(withIdentifier: self.completedSegue, sender: nil)
//    }
    
    @IBAction func editProfilePicture(_ sender: Any) {
        //profileCreator.swapPhoto(profilePicture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
