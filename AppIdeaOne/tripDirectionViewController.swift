//
//  tripDirectionViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 1/21/18.
//  Copyright © 2018 NickBajaj. All rights reserved.
//

import UIKit

class tripDirectionViewController: UIViewController {
    
    let tripDirectionSegue = "tripDirectionSegue"

    @IBAction func goingToBerkeley(_ sender: Any) {
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    @IBAction func leavingBerkeley(_ sender: Any) {
        self.performSegue(withIdentifier: self.tripDirectionSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
