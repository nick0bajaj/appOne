//
//  myPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/13/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

class myPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBorders()
        setLabels()
        setProfilePicture()
    }
    
    private let editPageSegue : String = "editPageSegue"
    
    private let db = DBProvider()
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var aboutMeLabel: UITextView!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBAction func editProfileButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.editPageSegue, sender: nil)
    }
    
    private func setLabels(){
        print("started to retrieve info")
        if let data = db.getUserProfile(userID: db.id){
            self.aboutMeLabel.text = data[Constants.ABOUTME] as! String
            self.emailAddressLabel.text = data[Constants.EMAIL] as? String
            self.phoneNumberLabel.text = data[Constants.PHONENUMBER] as? String
            let fn = data[Constants.FIRSTNAME]
            let ln = data[Constants.LASTNAME]
            self.myNameLabel.text = (fn! as! String) + " " + (ln! as! String)
        } else {
            self.alertTheUser(title: db.dataErrorMessage, message: "Sorry, could not get profile data")
        }
    }
    
    private func setProfilePicture(){
        print("Started to retrieve profile picture")
        let data : UIImage? = db.getProfilePicture()
        if(data != nil){
            self.profileImage.image = data!
        } else {
            self.alertTheUser(title: db.dataErrorMessage, message: "Sorry, could not get profile picture")
        }
    }
    
    private func createBorders(){
        emailAddressLabel.layer.borderColor = UIColor.lightGray.cgColor
        emailAddressLabel.layer.borderWidth = 0.5
        emailAddressLabel.layer.cornerRadius = 8
        aboutMeLabel.layer.borderColor = UIColor.lightGray.cgColor
        aboutMeLabel.layer.borderWidth = 0.5
        aboutMeLabel.layer.cornerRadius = 8
        phoneNumberLabel.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumberLabel.layer.borderWidth = 0.5
        phoneNumberLabel.layer.cornerRadius = 8
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
