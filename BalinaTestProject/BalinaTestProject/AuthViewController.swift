//
//  ViewController.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 03.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit
import HMSegmentedControl
import SwiftyJSON
import SWRevealViewController

class AuthViewController: UIViewController, SWRevealViewControllerDelegate{
    
    let selectedSegmentIndexKey = "selectedSegmentIndex"
    
    public func addSegmentControl(){
        let segmentedControl = HMSegmentedControl(sectionTitles: ["Login","Register"])
        segmentedControl?.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 40)
        segmentedControl?.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl?.addTarget(self, action: #selector(AuthViewController.segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentedControl?.selectionIndicatorLocation = .down
        segmentedControl?.selectionStyle = .fullWidthStripe
        segmentedControl?.backgroundColor = UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
        segmentedControl?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        segmentedControl?.selectionIndicatorColor = UIColor.white
        
        self.view.addSubview(segmentedControl!)
        
    }
    
    @objc private func segmentedControlChangedValue(segmentedControl :
        HMSegmentedControl){
        segmentSwitcher(index: segmentedControl.selectedSegmentIndex)
        UserDefaults.standard.set(segmentedControl.selectedSegmentIndex, forKey: selectedSegmentIndexKey)
    }
    var loginField : CustomTextField =  {
        let field = CustomTextField(frame: CGRect(x: 47, y: 230, width: 230, height: 35))
        field.placeholder = "Login"
        field.tag = 100
        return field
    }()
    var passwordField : CustomTextField  = {
        let field = CustomTextField(frame: CGRect(x: 47, y: 280, width: 230, height: 35))
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.tag = 200
        return field
    }()
    var passwordConfirmationField : CustomTextField  = {
        let field = CustomTextField(frame: CGRect(x: 47, y: 330, width: 230, height: 35))
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.tag = 300
        return field
    }()
    
    public func addLogInButton(){
        let button = UIButton(frame: CGRect(x: 47, y: 350, width: 230, height: 35))
        button.tag = 400
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(AuthViewController.logIn), for: .touchUpInside)
        self.view.addSubview(button)
    }
    public func addSignUpButton(){
        let button = UIButton(frame: CGRect(x: 47, y: 400, width: 230, height: 35))
        button.tag = 500
        button.setTitle("SIGN UP", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(AuthViewController.signUp), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    public func logIn(){
        API.logIn(login: loginField.text!, password: passwordField.text!) { (status, responce) in
            switch status {
            case true:
                Authentication.userLogin = (responce?["data"]["login"].string!) ?? "error"
                Authentication.token = (responce?["data"]["token"].string!) ?? "error"
                self.segueToMainScreen()
               
                
            case false:
                print("error")
            }
         
            
            print(status)
        }
        
    }
    public func signUp(){
        //username should contains only [a-z 0-9]
        API.singUp(login: loginField.text!, password: passwordField.text!) { (status, responce) in
            switch status {
            case true:
                Authentication.userLogin = (responce?["data"]["login"].string!) ?? "error"
                Authentication.token = (responce?["data"]["token"].string!) ?? "error"
                self.segueToMainScreen()
            case false:
                print("error")
            }
        }
    }
    public func segueToMainScreen(){
        let rearVC                      = RearViewController()
        let photosVC                    = PhotosViewController()
        let frontNavigationController   = UINavigationController(rootViewController: photosVC)
        let revalController             = SWRevealViewController(rearViewController: rearVC, frontViewController: frontNavigationController)
        revalController?.delegate       = self
        
        present(revalController!, animated: true, completion: nil)
        
        
    }
    
    public func segmentSwitcher(index : Int){
        
        switch index {
        case 0:
            for subview in view.subviews{
                if subview.tag == 300 || subview.tag == 500 {
                    subview.removeFromSuperview()
                }
            }
            addLogInButton()
           
        case 1:
            for subview in view.subviews{
                if  subview.tag == 400 {
                    subview.removeFromSuperview()
                }
            }
            self.view.addSubview(passwordConfirmationField)
            addSignUpButton()
            
        default:
                print("")
        }
        
    }

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmentControl()
        addLogInButton()
        self.view.addSubview(loginField)
        self.view.addSubview(passwordField)
        
        UserDefaults.standard.set(0, forKey: selectedSegmentIndexKey)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

