//
//  SignInVCViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/6/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private let loginSegue = "loginSegue"
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func Login(_ sender: AnyObject) {
        var providedErrorMessage : String? = nil
        var errorMessage : String? = nil
        let titleErrorMessage = Authenticator.authorizer.authenticatorErrorMessage
        errorMessage = Authenticator.authorizer.login(Email: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
            providedErrorMessage = message
        })
        if(providedErrorMessage != nil){
            self.alertTheUser(title: titleErrorMessage, message: providedErrorMessage!)
            print("Login failed - func Login")
        } else if (errorMessage != nil){
            self.alertTheUser(title: titleErrorMessage, message: errorMessage!)
            print("Login failed - func Login")
        } else {
            print("Login Completed! - from func Login")
            self.performSegue(withIdentifier: self.loginSegue, sender: nil)
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
