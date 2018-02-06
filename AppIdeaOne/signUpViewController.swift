//
//  SignUpViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/9/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var desiredPasswordTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    private let myPage = "editPageSegue"
        
    @IBAction func signUpButton(_ sender: AnyObject) {
        var providedErrorMessage: String? = nil
        var errorMessage : String? = nil
        let titleErrorMessage = Authenticator.authorizer.authenticatorErrorMessage
        errorMessage = Authenticator.authorizer.signUp(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailAddressTextField.text!, firstPassword: desiredPasswordTextField.text!, secondPassword: confirmPasswordTextField.text!, loginHandler: { (message) in
            providedErrorMessage = message
            if (message != nil){
                self.alertTheUser(title: "Problem with Creating Account", message: message!)
            } else {
                self.performSegue(withIdentifier: self.myPage, sender: nil)
            }
        })
        if(providedErrorMessage != nil){
            self.alertTheUser(title: titleErrorMessage, message: providedErrorMessage!)
        } else if (errorMessage != nil){
            self.alertTheUser(title: titleErrorMessage, message: errorMessage!)
        } else {
            print("Signup Completed! - from func SignUpButton")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
