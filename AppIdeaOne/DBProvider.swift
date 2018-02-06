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
import FirebaseFirestore
import GooglePlaces
import UIKit


class DBProvider {
    
    static let instance = DBProvider()
    
    let id = Auth.auth().currentUser!.uid
    
    let dataErrorMessage = "Problem with Uploading Data"
    
    private let db = Firestore.firestore()
    
    var Instance : DBProvider {
        return .instance
    }
    
    var userRef: DatabaseReference {
    
        return Database.database().reference().child("users").child(Constants.ID)
    
    }
    
    var userStorageRef: StorageReference {
        return Storage.storage().reference().child("users").child(Constants.ID)
    }
    
    func saveUser(firstName: String, lastName: String, email: String, password: String)-> String?{
        let userDate : [String : AnyObject] = [
            Constants.EMAIL : email as AnyObject!,
            Constants.FIRSTNAME : firstName as AnyObject!,
            Constants.LASTNAME : lastName as AnyObject!,
            Constants.PASSWORD : password as AnyObject!,
        ]
        var errorMessage : String? = nil
        errorMessage = uploadMapToUser(location: Constants.USERS, map: userDate)
        return errorMessage
    }
    
    func uploadImage(_ image: UIImage, completionBlock: @escaping (_ url: URL?, _ errorMessage: String?) -> Void){
        if let imageData =  UIImageJPEGRepresentation(image, 0.8){
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            _ = userStorageRef.child(self.id).child(Constants.PROFILEPICTURE).putData(imageData, metadata: metadata, completion: {(metadata, error) in
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
        userRef.child(self.id).child(Location).setValue(data)
    }
    
    func uploadMapToUser(location: String, map : [String : AnyObject]) -> String?{
        var errorMessage : String? = nil
        db.collection(location).document(self.id).setData(map){
            err in
            if let err = err {
                print("Error adding document in uploadMapToUser: \(err)")
                errorMessage = "Sorry, could not upload info. Try again later"
            }
        }
        return errorMessage
    }
    
    func uploadTrip(trip : [String : AnyObject])-> String? {
        //Document added with ID: \(ref!.documentID)
        var errorMessage : String? = nil
        db.collection(Constants.TRIPS).addDocument(data: trip){
            err in
            if let err = err {
                print("Error adding document in uploadTrip: \(err)")
                errorMessage = "Sorry, could not post trip. Try again later."
            }
        }
        return errorMessage
    }
    
    func getUserProfile(userID: String)-> [String : AnyObject]?{
        var data : [String: AnyObject]? = nil
        db.collection(Constants.USERS).document(userID).getDocument { (document, error) in
            if let document = document {
                print("Document data: \(String(describing: document.data()))")
                data = document.data()
            } else {
                print("Document does not exist, error:  \(String(describing: error))")
            }
        }
        return data
    }
}
