//
//  DetailPhotoViewController.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 05.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    let selecdedRow = "selectedRow" //UserDefaults
    var selectedIndex : Int {
        get{
            return UserDefaults.standard.value(forKey: selecdedRow) as! Int
        }
    }
    let formatter = DateFormatter()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var photoDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func saveComment(_ sender: Any) {
    }
 
    func fillData(){
        
        let image = UIImage(data: APICoreData.photos?[selectedIndex].photo as! Data)
        imageView.image         = image
        formatter.dateFormat    = "dd-MM-yyyy"
        photoDate.text          = formatter.string(from: (APICoreData.photos?[selectedIndex
        ].date)! as Date)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        self.navigationController?.navigationBar.barTintColor =  UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
