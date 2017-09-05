//
//  MainPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 8/2/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let list = ["Milk", "Honey", "Bread", "Tomatoes"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "primaryCell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }

}
