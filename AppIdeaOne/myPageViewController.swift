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
import FirebaseStorage

class myPageViewController: UIViewController {
    
    let editPageSegue : String = "editPageSegue"
    let db = DBProvider()
    
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var aboutMeLabel: UITextView!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBAction func editProfileButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.editPageSegue, sender: nil)
    }
    
    var userRef: DatabaseReference {
        
        return Database.database().reference().child(Constants.ID)
        
    }
    
    var userSRef : StorageReference {
        return Storage.storage().reference().child(Constants.ID)
    }
    
    
    
    func setLabels(){
        print("started to retrieve info")
        userRef.child(DBProvider.Instance.id!).observeSingleEvent(of: .value, with: {
            snapshot in
            if let items = snapshot.value as? [String:String]{
                self.aboutMeLabel.text = items[Constants.ABOUTME]
                self.emailAddressLabel.text = items[Constants.EMAIL]
                self.phoneNumberLabel.text = items[Constants.PHONENUMBER]
                let fn = items[Constants.FIRSTNAME]
                let ln = items[Constants.LASTNAME]
                self.myNameLabel.text = fn! + " " + ln!
            }
        })
    }
    
    func setProfilePicture(){
        print("Started to retrieve profile picture")
        let storageRef = userSRef.child(db.id!).child("Profile Picture")
        let maxSize: Int64 = 3 * 1024 * 1024
        storageRef.getData(maxSize: maxSize) { (data, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                self.profileImage.image = UIImage(data: data!)
            }
        }
    }
    
    func createBorders(){
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBorders()
        setLabels()
        setProfilePicture()
    }
    
}
