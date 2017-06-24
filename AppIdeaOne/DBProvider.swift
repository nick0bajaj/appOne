//
//  DBProvider.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/15/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import Foundation
import FirebaseDatabase


class DBProvider {
    private static let instance = DBProvider()
    static var Instance : DBProvider {
        return instance
    }
    
    var ref: DatabaseReference {
    
        return Database.database().reference()
    
    }
    
    var userRef : DatabaseReference {
        return ref.child(Constants.ID)
    }
    
    func saveUser(withID: String, firstName: String, lastName: String, email: String, password: String){
        let emailChecker = supportedColleges()
        let college: String = emailChecker.whatCollege(email: email)
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.FIRSTNAME : firstName, Constants.LASTNAME : lastName, Constants.PASSWORD: password, Constants.COLLEGES : college]
        userRef.child(withID).child(Constants.DATA).setValue(data)
    }
    
    func updateProfile(number: String, aboutMe: String) {
        
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
