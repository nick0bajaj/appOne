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
    
    let authenticatorErrorMessage = "Problem with Authentication"
    
    private let db = DBProvider()
    
    func signUp(firstName: String, lastName: String, email: String, firstPassword: String, secondPassword: String, loginHandler: LoginHandler?)-> String? {
        var errorMessage : String? = nil
        errorMessage = checkName(firstName: firstName, lastName: lastName)
        errorMessage = checkPassword(firstPassword: firstPassword, secondPassword: secondPassword)
        if((errorMessage) != nil){
            return errorMessage
        }
        Auth.auth().createUser(withEmail: email, password: firstPassword, completion: {
            (user, error) in
            if (error != nil){
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                errorMessage = self.db.saveUser(firstName: firstName, lastName: lastName, email: email, password: firstPassword)
                if(errorMessage == nil){
                 errorMessage = self.login(Email: email, password: firstPassword, loginHandler: loginHandler)
                }
            }
        })
        return errorMessage
    }
    
    func login(Email: String, password: String, loginHandler : LoginHandler?) -> String? {
        var errorMessage : String? = nil
        errorMessage = checkEmailAndPassword(email: Email, firstPassword: password, secondPassword: password)
        if((errorMessage) != nil){
            return errorMessage
        }
        Auth.auth().signIn(withEmail: Email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                loginHandler?(nil)
            }
        })
        return nil
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
    private func checkName(firstName: String, lastName: String) -> String? {
        if(firstName == ""){
            return "Please enter your first name"
        } else if (lastName == ""){
            return "Please enter your last name"
        }
        return nil
    }
    
    private func checkPassword(firstPassword: String, secondPassword: String) -> String? {
        let hasLowerCase = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: firstPassword)
        let hasUpperCase = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: firstPassword)
        let hasDigit = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*").evaluate(with: firstPassword)
        if(firstPassword == ""){
            return "Please enter a desired password"
        } else if (secondPassword == ""){
            return "Please confirm your password"
        } else if (firstPassword != secondPassword){
            return "Passwords don't match"
        } else if !(firstPassword.count >= 9){
            return "Password must be at least 9 characters"
        } else if (!hasDigit){
            return "Password must contains a digit"
        } else if (!hasLowerCase){
            return "Password must have at least 1 lower case character"
        } else if (!hasUpperCase){
            return "Password must have at least 1 upper case character"
        }
        return nil
    }
    
    
    private func isBerkeleyEmail(email : String) -> Bool {
        let berkeleyRegex : String = "[A-Z0-9a-z._%+-]+@[bB][eE][rR][kK][eE][lL][eE][yY].[eE][dD][uU]"
        return NSPredicate(format: "Self Matches %@", berkeleyRegex).evaluate(with:email)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func checkEmail(email: String) -> String? {
        var errorMessage : String? = nil
        if(isValidEmail(email: email)){
            errorMessage = "Please Enter a Valid Email"
        } else if(isBerkeleyEmail(email: email)){
            errorMessage = "Sorry, this app is currently only for Berkeley students. Try using a Berkeley email if you have one."
        }
        return errorMessage
    }
    
    private func checkEmailAndPassword(email: String, firstPassword: String, secondPassword: String) -> String? {
        if let errorMessage : String = checkPassword(firstPassword: firstPassword, secondPassword: secondPassword){
            return errorMessage
        } else if let errorMessage: String = checkEmail(email: email){
            return errorMessage
        } else {
            return nil
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

