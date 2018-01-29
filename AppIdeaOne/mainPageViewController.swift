//
//  MainPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 8/2/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let searchSegue = "searchSegue"
    
    var searching : Bool = false
    
    //let defaultTableList
    
    var searchTableList : [String: AnyObject]? = nil
    
    @IBAction func searchButton(_ sender: Any) {
        searching = true
        self.performSegue(withIdentifier: self.searchSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searching = false
    }
    
    private let list = ["Milk", "Honey", "Bread", "Tomatoes"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "primaryCell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripDirectionVC = segue.destination as! tripDirectionViewController
        tripDirectionVC.fromSearch = true
    }

}
