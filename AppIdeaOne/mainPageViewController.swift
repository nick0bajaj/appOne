//
//  MainPageViewController.swift
//  Split
//
//  Created by Nikhil Bajaj on 8/2/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct tripPost {
    let date : NSDate!
    let address : String!
}

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [tripPost]()
    
    let cellTitle = "cell"
    
    let searchSegue = "searchSegue"
    
    let db = Firestore.firestore()
    
    var searching : Bool = false
    
    //let defaultTableList
    
    var searchTableList : [String: AnyObject]? = nil
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    @IBAction func searchButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.searchSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self as? UITableViewDataSource
        if(searching){
            setupTableSearch()
        } else {
            setupTableDefault()
        }
    }
    
    private func setupTableSearch() {
        
    }

    private func setupTableDefault(){
        let date : Double = Date().timeIntervalSince1970
        db.collection(Constants.TRIPS).whereField(Constants.NSDATE, isGreaterThanOrEqualTo: date).addSnapshotListener({querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New city: \(diff.document.data())")
                    let date = diff.document.data()[Constants.DATE] as! NSDate
                    let address = diff.document.data()[Constants.ADDRESS] as! String
//                    let date = snapshot.value(forKey: Constants.DATE) as! NSDate
//                    let address = snapshot.value(forKey: Constants.ADDRESS) as! String
                    self.posts.insert(tripPost(date: date, address: address), at: 0)
                    self.tripsTableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: cellTitle)
        cell?.textLabel?.text = posts[indexPath.row].address
        cell?.detailTextLabel?.text = posts[indexPath.row].date.description(with: "MM/dd/yy")
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripDirectionVC = segue.destination as! tripDirectionViewController
        tripDirectionVC.fromSearch = true
    }

}
