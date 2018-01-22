//
//  SignUpViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/9/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
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
        let auth = Authenticator()
        let nameCheck = auth.checkName(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
        if (nameCheck != "") {
            self.alertTheUser(title: "Problem with Authentication", message: nameCheck)
            return
        }
        let emailCheck = auth.checkEmail(email: emailAddressTextField.text!)
        if (emailCheck != ""){
            self.alertTheUser(title: "Problem with Authentication", message: emailCheck)
            return
        }
        let passwordCheck = auth.passwordsPass(firstPassword: desiredPasswordTextField.text!, secondPassword: confirmPasswordTextField.text!)
        if (passwordCheck != ""){
            self.alertTheUser(title: "Problem with Authentication", message: passwordCheck)
            return
        } else {
            auth.signUp(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailAddressTextField.text!, password: desiredPasswordTextField.text!, loginHandler: { (message) in
                if (message != nil){
                    self.alertTheUser(title: "Problem with Creating Account", message: message!)
                } else {
                    self.performSegue(withIdentifier: self.myPage, sender: nil)
                }
            })
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
