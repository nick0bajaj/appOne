//
//  Authenticator.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/6/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginError {
    static let invalidEmail = "Invalid Email Address, please provide the correct Email Address"
    static let wrongPassword = "Wrong Password, Please Enter the Corrrect Password"
    static let problemConnecting = "Problem connecting to Database"
    static let emailAlreadyInUse = "Email already in use, please use that account"
    static let weakPassword = "Password should be at least 6 characters long"
    static let userNotFound = "Sorry, this account was not found"
}

class Authenticator {
    private static let auth = Authenticator();
    
    static var authorizer: Authenticator {
        return auth
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, loginHandler: LoginHandler?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if (error != nil){
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                if user?.uid != nil {
                    DBProvider.Instance.saveUser(withID: user!.uid, firstName: firstName, lastName: lastName, email: email, password: password)
                    self.login(Email: email, password: password, loginHandler: loginHandler)
                }
            }
        })
    }
    
    func login(Email: String, password: String, loginHandler : LoginHandler?){
        Auth.auth().signIn(withEmail: Email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                loginHandler?(nil)
            }
        })
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?){
        if let errCode = AuthErrorCode(rawValue: err.code) {
            switch errCode {
            case .wrongPassword:
                loginHandler?(LoginError.wrongPassword)
                break;
            case .invalidEmail:
                loginHandler?(LoginError.invalidEmail)
                break;
            case .emailAlreadyInUse:
                loginHandler?(LoginError.emailAlreadyInUse)
                break;
            case .userNotFound:
                loginHandler?(LoginError.userNotFound)
                break;
            default:
                loginHandler?(LoginError.problemConnecting)
                break;
            }
        }

}
    func checkName(firstName: String, lastName: String) -> String {
        if(firstName == ""){
            return "Please enter your first name"
        } else if (lastName == ""){
            return "Please enter your last name"
        } else {
            return ""
        }
    }
    
    func passwordsPass(firstPassword: String, secondPassword: String) -> String {
        let password = firstPassword
        let hasLowerCase = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: password)
        let hasUpperCase = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password)
        let hasDigit = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*").evaluate(with: password)
        if(firstPassword == ""){
            return "Please enter a desired password"
        } else if (secondPassword == ""){
            return "Please confirm your password"
        } else if (firstPassword != secondPassword){
            return "Passwords don't match"
        } else if !(firstPassword.characters.count >= 9){
            return "Password must be at least 9 characters"
        } else if (!hasDigit){
            return "Password must contains a digit"
        } else if (!hasLowerCase){
            return "Password must have at least 1 lower case character"
        } else if (!hasUpperCase){
            return "Password must have at least 1 upper case character"
        } else {
            return ""
        }
    }
    
    
    private func isValidEmail(email : String) -> Bool {
        let collegeChecker = supportedColleges()
        let college = collegeChecker.whatCollege(email: email)
        if(college == ""){
            return false
        } else {
            return true
        }
    }
    
    private func isEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func checkEmail(email: String) -> String {
        if(isValidEmail(email: email)){
            return ""
        }
        if(isEmail(email: email)){
            return "Sorry, this app is currently only for Berkeley students. Try using a Berkeley email if you have one."
        } else {
            return "Please use a valid email address"
        }
        
    }
    
    func logout() -> Bool{
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false;
            }
        }
        return true
    }


}

