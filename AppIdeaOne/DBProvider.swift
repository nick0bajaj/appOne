//
//  DBProvider.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/15/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import UIKit


class DBProvider {
    
    private static let instance = DBProvider()
    
    static var Instance : DBProvider {
        return instance
    }
    
    let id = Auth.auth().currentUser?.uid
    
    var userRef: DatabaseReference {
    
        return Database.database().reference().child(Constants.ID)
    
    }
    
    var userStorageRef: StorageReference {
        return Storage.storage().reference().child(Constants.ID)
    }
    
    
    func saveUser(withID: String, firstName: String, lastName: String, email: String, password: String){
        let emailChecker = supportedColleges()
        let college: String = emailChecker.whatCollege(email: email)
        uploadInfo(Location: Constants.EMAIL, Value: email)
        uploadInfo(Location: Constants.COLLEGE, Value: college)
        uploadInfo(Location: Constants.FIRSTNAME, Value: firstName)
        uploadInfo(Location: Constants.LASTNAME, Value: lastName)
        uploadInfo(Location: Constants.PASSWORD, Value: password)
        uploadInfo(Location: Constants.PHONENUMBER, Value: "")
        uploadInfo(Location: Constants.ABOUTME, Value: "")
        
    }
    
    func uploadImage(_ image: UIImage, completionBlock: @escaping (_ url: URL?, _ errorMessage: String?) -> Void){
        _ = "Profile Picture"
        if let imageData =  UIImageJPEGRepresentation(image, 0.8){
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            _ = userStorageRef.child(self.id!).child(Constants.PROFILEPICTURE).putData(imageData, metadata: metadata, completion: {(metadata, error) in
                if let metadata = metadata{
                    completionBlock(metadata.downloadURL(), nil)
                } else {
                    //error
                    completionBlock(nil, error?.localizedDescription)
                }
            })
        } else {
            //error
            completionBlock(nil, "Image couldn't be converted to data.")
        }
    }
    
    func updateProfile(number: String, aboutMe: String) {
        uploadInfo(Location: Constants.PHONENUMBER, Value: number)
        uploadInfo(Location: Constants.ABOUTME, Value: aboutMe)
    }
    
    func uploadInfo(Location: String, Value : String) {
        var data = Value
        if(Location != Constants.PASSWORD){
            data = Value.lowercased()
        }
        userRef.child(self.id!).child(Location).setValue(data)
    }
    
    func uploadTrips(Location: String, Value: String) {
        userRef.child(self.id!).observeSingleEvent(of: .value, with: {
            snapshot in
            print(snapshot.value ?? "Could not print snapshot.value")
            if let items = snapshot.value as? [String:String]{
                if items[Constants.TRIPS] != nil {
                    self.userRef.child(self.id!).observeSingleEvent(of: .value, with: {
                        snapshot in
                        if let allTrips = snapshot.value as? [String:String]{
                            let numberOfTrips : Int = allTrips.keys.count//this line not working, count returns (function)
                            print("All Trips is: \(allTrips)")
                            print("The number of trips is: \(numberOfTrips)")
                            self.userRef.child(self.id!).child(Constants.TRIPS).child("\(numberOfTrips)").child(Location).setValue(Value)
                        } else {
                            print("Could not set AllTrips - uploadTrips()")
                        }
                    })
                } else {
                    print("No Previous Trips - UploadTrips()")
                    self.userRef.child(self.id!).child(Constants.TRIPS).child("0").child(Location).setValue(Value)
                }
                self.userRef.child(self.id!).child(Constants.TRIPS).child("\(index)").child(Location).setValue(Value)
            } else {
                print("Couldnt get Trips - in uploadTrips - DBProvider.swift ")
            }
        })
    }
    

    

//    func deleteTrip(){
//        
//    }

    
//    func deleteAccount(){
//        
//    }
}
