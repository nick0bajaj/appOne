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
        let auth = Authenticator()
        let emailCheck = auth.checkEmail(email: emailTextField.text!)
        if (emailCheck != "") {
            alertTheUser(title: "Problem with Authentication", message: emailCheck)
        } else if (auth.passwordsPass(firstPassword: passwordTextField.text!, secondPassword: passwordTextField.text!) != ""){
            alertTheUser(title: "Problem with Authentication", message: "Invalid Password")
        } else {
        Authenticator.authorizer.login(Email: emailTextField.text!, password: passwordTextField.text!,
            loginHandler: { (message) in
                if (message != nil) {
                    print("login failed!!")
                    self.alertTheUser(title: "Problem With Authentication", message: message!)
                } else {
                    print("Login Completed! ~ func Login")
                    self.performSegue(withIdentifier: self.loginSegue, sender: nil)
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
