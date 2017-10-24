//
//  Authentication.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 03.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import Foundation
class Authentication {
    static var token : String {
        get {
            return UserDefaults.standard.value(forKey: "token") as! String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    static var userLogin : String {
        get {
            return UserDefaults.standard.value(forKey: "login") as! String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "login")
        }
    }
    
}
