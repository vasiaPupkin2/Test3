//
//  RearViewController.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 04.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit

class RearViewController: UIViewController {
    
    let cellId = "RearCell"
    var presentedRow : Int?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource    = self
        userNameLabel.text      = UserDefaults.standard.value(forKey: "login") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension RearViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellId)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text    = "Photo"
            cell.imageView?.image   = UIImage(named: "002-social")
            cell.backgroundColor    = UIColor.clear
        case 1 :
            cell.textLabel?.text    = "Map"
            cell.imageView?.image   = UIImage(named: "003-globe")
            cell.backgroundColor    = UIColor.clear
        default:
            break
        }
        return cell
    }
    
}
extension RearViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row                 = indexPath.row
        let revalController     = self.revealViewController()
        var newFrontController  = UIViewController()
        
        switch row {
        case let sameRowCase where sameRowCase == presentedRow:
            revalController?.setFrontViewPosition(.left, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            return
        case 0 :
            let frontController = PhotosViewController()
            newFrontController  = UINavigationController(rootViewController: frontController)
        case 1 :
            let frontController = MapViewController()
            newFrontController  = UINavigationController(rootViewController: frontController)
        default:
            break
        }
        presentedRow = row
        revalController?.pushFrontViewController(newFrontController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
