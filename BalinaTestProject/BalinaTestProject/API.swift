//
//  API.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 03.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class API {
    private static let baseURL = "http://213.184.248.43:9099/api"
    
    enum Path : String {
        case signIn                 = "/account/signin"
        case signUp                 = "/account/signup"
        //To delete image use getPutDeleteImage +/{imageId}
        case getPutDeleteImage      = "/image"
        //To indicate with what image comment you work use : getPutDeleteComment +/{imageId}/comment.
        //To delete comment use :  getPutDeleteComment +/{imageId}/comment/{commentId}
        case getPutDeleteComment    = "/image/"
        
    }
   
    
    static func logIn(login : String, password : String, completeon : @escaping (_ status : Bool, _ result : JSON?)  ->()){
        
        request(baseURL + Path.signIn.rawValue, method: .post, parameters: ["login": login,"password":password], encoding : JSONEncoding.default).validate(contentType: ["application/json"]).validate(statusCode: 200...300)
            .responseJSON { (responce) in
                
                if responce.result.isSuccess {
                    print(JSON(responce.result.value))
                    completeon(true, JSON(responce.result.value))
                    
                    
                } else {
                    if let status = responce.response?.statusCode {
                        
                        switch status {
                        case 400    :  print("security.signin.incorrect")
                            completeon(false, nil)
                        case 404    :  print("not found")
                            completeon(false, nil)
                        case 415    :  print("unsupported media type")
                            completeon(false, nil)
                        default     :  print("unrecogizeble signIn error" + String(status))
                            completeon(false, nil)
                        }
                    }
                    
                }
                
        }
        
    }
    
    static func singUp(login : String, password : String, completeon : @escaping (_ status : Bool, _ result : JSON?)  ->()){
        request(baseURL + Path.signUp.rawValue, method: .post, parameters: ["login": login,"password":password], encoding : JSONEncoding.default)
            .validate(contentType: ["application/json"]).validate(statusCode: 200...300)
            .responseJSON { (responce) in
                
                if responce.result.isSuccess {
                    completeon(true, JSON(responce.result.value))
                    print(responce.result.value)
                    
                } else {
                    if let status = responce.response?.statusCode {
                        //username should contains only [a-z 0-9]
                        switch status {
                        case 400    :  print("security.signup.login-already-use")
                            completeon(false, nil)
                        case 404    :  print("not found")
                             completeon(false, nil)
                        case 415    :  print("unsuppirted media type")
                             completeon(false, nil)
                        default     :  print("unrecogizeble signup error" + String(status))
                            completeon(false, nil)
                        }
                    }
                    
                }
                
        }
        
    }
   
    

    
}
