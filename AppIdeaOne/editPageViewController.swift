//
//  editPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/23/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class editPageViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBorders()
        setLabels()
    }
        
    private let profileCreator = setUpProfile()
    
    private let db = DBProvider()
    
    private let profileCreatedSegue = "profileCreatedSegue"
    
    private var ref: DatabaseReference {
        return Database.database().reference()
    }
    
    private var userRef : DatabaseReference {
        return ref.child(Constants.ID)
    }
    
    @IBOutlet weak var myName: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var aboutMeTextField: UITextView!
    
    @IBAction func completedButton(_ sender: Any) {
        db.updateProfile(number: phoneNumberTextField.text!, aboutMe: aboutMeTextField.text!)
        self.performSegue(withIdentifier: self.profileCreatedSegue, sender: nil)
        db.uploadImage(profileImageView.image!, completionBlock: {(fileURL, errorMessage) in
            print(fileURL ?? "Could not find fileURL")
            print(errorMessage ?? "Could not find errorMessage")
        })
    }
    
    @IBAction func editProfilePicture(_ sender: Any) {
        //profileCreator.swapPhoto(profilePicture)
    }
    
    @IBAction func changePhotoButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
        } else {
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if self.aboutMeTextField.text == "About Me"{
            return true
        }else {
            return false
        }
    }
    
    private func setLabels(){
        userRef.child(DBProvider.Instance.id!).observeSingleEvent(of: .value, with: {
            snapshot in
            if let items = snapshot.value as? [String:String]{
                let aboutMe = items[Constants.ABOUTME]
                if aboutMe == "" || aboutMe == "About Me"{
                    self.aboutMeTextField.text = "About Me"
                    self.aboutMeTextField.textColor = UIColor.lightGray
                    self.aboutMeTextField.font = UIFont(name: "FuturaMedium", size: 17)
                    self.aboutMeTextField.clearsOnInsertion = true
                }
                self.emailTextField.text = items[Constants.EMAIL]
                self.phoneNumberTextField.text = items[Constants.PHONENUMBER]
                let fn = items[Constants.FIRSTNAME]?.uppercased()
                let ln = items[Constants.LASTNAME]?.uppercased()
                self.myName.text = fn! + " " + ln!
            }
        })
    }
    
    private func createBorders(){
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.cornerRadius = 8
        aboutMeTextField.layer.borderColor = UIColor.lightGray.cgColor
        aboutMeTextField.layer.borderWidth = 0.5
        aboutMeTextField.layer.cornerRadius = 8
        phoneNumberTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumberTextField.layer.borderWidth = 0.5
        phoneNumberTextField.layer.cornerRadius = 8
    }
}
