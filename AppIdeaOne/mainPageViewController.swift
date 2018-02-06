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
    let date : String!
    let address : String!
}

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let lat = 0.0144927536231884
    let lon = 0.0181818181818182
    let withinDistanceInMiles = 15.0
    
    var posts = [tripPost]()
    
    let cellTitle = "cell"
    
    let searchSegue = "searchSegue"
    
    let db = Firestore.firestore()
    
    var searching : Bool = false
    
    var isEmmigrating : Bool = false
    
    var searchCriteria : [String:AnyObject]? = nil
    
    var searchButtonClicked = false
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    @IBAction func searchButton(_ sender: Any) {
        searchButtonClicked = true
        self.performSegue(withIdentifier: self.searchSegue, sender: nil)
    }
    
    @IBAction func postTripButton(_ sender: Any) {
        searchButtonClicked = false
        self.performSegue(withIdentifier: self.searchSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        print("Searching variable is set to \(searching)")
        if(searching){
            setupTableSearch()
        } else {
            setupTableDefault()
        }
    }
    
    private func setupTableSearch() {
        print("inside setupTableSearch()")
        let searchDate : NSDate = (searchCriteria![Constants.NSDATE] as! NSDate)
        let point : GeoPoint = searchCriteria![Constants.GEOPOINT] as! GeoPoint
        let lat = point.latitude
        let lon = point.longitude
        let lbGeoPoint = getLowerBoundGeoPoint(latitude: lat, longitude: lon)
        let ubGeoPoint = getUpperBoundGeoPoint(latitude: lat, longitude: lon)
        db.collection(Constants.TRIPS).whereField(Constants.ISEMMIGRATING, isEqualTo: isEmmigrating).whereField(Constants.NSDATE, isEqualTo: searchDate).whereField(Constants.GEOPOINT, isGreaterThan: lbGeoPoint).whereField(Constants.GEOPOINT, isLessThan: ubGeoPoint).addSnapshotListener({querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("Search city: \(diff.document.data())")
                    let date = diff.document.data()[Constants.DATE] as! String
                    let address = diff.document.data()[Constants.ADDRESS] as! String
                    self.posts.insert(tripPost(date: date, address: address), at: 0)
                    self.tripsTableView.reloadData()
                }
            }
        })
    }
    
    private func getUpperBoundGeoPoint(latitude: Double, longitude: Double) -> GeoPoint {
        let upperBoundLat = latitude + (lat * withinDistanceInMiles)
        let upperBoundLon = longitude + (lon * withinDistanceInMiles)
        return GeoPoint(latitude: upperBoundLat, longitude: upperBoundLon)
    }
    
    private func getLowerBoundGeoPoint(latitude: Double, longitude: Double) -> GeoPoint {
        let lowerBoundLat = latitude - lat * withinDistanceInMiles
        let lowerBoundLon = longitude - lon * withinDistanceInMiles
        return GeoPoint(latitude: lowerBoundLat, longitude: lowerBoundLon)
    }

    private func setupTableDefault(){
        let date = NSDate.init().timeIntervalSince1970
        db.collection(Constants.TRIPS).whereField(Constants.NSDATE, isGreaterThanOrEqualTo: date).addSnapshotListener({querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New city: \(diff.document.data())")
                    let date = diff.document.data()[Constants.DATE] as! NSDate
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let stringDate: String = dateFormatter.string(from: date as Date)
                    let address = diff.document.data()[Constants.ADDRESS] as! String
                    self.posts.insert(tripPost(date: stringDate, address: address), at: 0)
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
        cell?.detailTextLabel?.text = posts[indexPath.row].date.description
        cell?.detailTextLabel?.text = posts[indexPath.row].address
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripDirectionVC = segue.destination as! tripDirectionViewController
        tripDirectionVC.fromSearch = searchButtonClicked
    }

}
