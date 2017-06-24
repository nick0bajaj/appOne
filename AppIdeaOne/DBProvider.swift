//
//  DBProvider.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/15/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class DBProvider {
    private static let instance = DBProvider()
    static var Instance : DBProvider {
        return instance
    }
    
    let id = Auth.auth().currentUser?.uid
    
    var ref: DatabaseReference {
    
        return Database.database().reference()
    
    }
    
    var userRef : DatabaseReference {
        return ref.child(Constants.ID)
    }
    
    func saveUser(withID: String, firstName: String, lastName: String, email: String, password: String){
        let emailChecker = supportedColleges()
        let college: String = emailChecker.whatCollege(email: email)
        uploadInfo(Location: Constants.EMAIL, Value: email)
        uploadInfo(Location: Constants.COLLEGE, Value: college)
        uploadInfo(Location: Constants.FIRSTNAME, Value: firstName)
        uploadInfo(Location: Constants.LASTNAME, Value: lastName)
        uploadInfo(Location: Constants.PASSWORD, Value: password)
        
    }
    
    func updateProfile(number: String, aboutMe: String) {
        
    }
    
    func uploadInfo(Location: String, Value : Any) {
        userRef.child(self.id!).child(Location).setValue(Value)
    }
    func retrieveInfo(Location : String) -> String{
        print("started to retrieve info")
        var rtn = ""
        userRef.child(self.id!).observeSingleEvent(of: .value, with: {(snapshot) in
        let value = snapshot.value as? NSDictionary
        rtn = (value?[Location] as? String)!
        }) { (error) in
            print(error.localizedDescription)
        }
        return rtn
    }
    
//    func swapPhoto(photo){
//        
//    }
//    
//    func createTrip(){
//        
//    }
//    
//    func deleteTrip(){
//        
//    }
//    
//    func updateTrip(){
//        
//    }
//    
//    func deleteAccount(){
//        
//    }
    
    
    
    
    
    
}
