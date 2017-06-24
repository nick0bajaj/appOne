//
//  supportedColleges.swift
//  Split
//
//  Created by Nikhil Bajaj on 6/15/17.
//  Copyright © 2017 NickBajaj. All rights reserved.
//

import Foundation


class supportedColleges {
    private let emailToCollege: Dictionary<String, String> = ["[A-Z0-9a-z._%+-]+@[bB][eE][rR][kK][eE][lL][eE][yY].[eE][dD][uU]" : "Univeristy of California, Berkeley"]
    
    func whatCollege(email: String) -> String{
        for (regex, school) in emailToCollege {
            if(isValidSchool(email: email, regex: regex)){
                return school
            }
        }
        return ""
        
    }
    
    
    private func isValidSchool(email : String, regex: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
}

