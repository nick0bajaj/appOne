//
//  menuViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/13/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseAuth

class menuViewController: UIViewController {

    let logoutSegue = "logoutSegue"
    @IBAction func logoutButton(_ sender: Any) {
        let auther = Authenticator()
        if !(auther.logout()) {
            self.alertTheUser(title: "Error: Could not Logout", message: "Sorry about this. Try restarting the app and try again.")
        } else {
            performSegue(withIdentifier: self.logoutSegue, sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}
