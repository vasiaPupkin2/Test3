//
//  MapViewController.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 04.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit
import GoogleMaps
import SWRevealViewController
class MapViewController: UIViewController {
    
    func setNavigationBar(){
        let revalController = SWRevealViewController()
        self.navigationController?.navigationBar.addGestureRecognizer(revalController.panGestureRecognizer())
        let revealButtonItem = UIBarButtonItem(image: UIImage(named : "reveal-icon"), style: .bordered, target: revalController, action: #selector(SWRevealViewController.revealToggle(_:)))
        
        self.navigationItem.leftBarButtonItem = revealButtonItem
        self.navigationItem.title = "Map"
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor =  UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        setNavigationBar()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.camera(withLatitude: 37.3212, longitude: -122.3789, zoom: 5)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        var i = 0
        while i != APICoreData.photos?.count {
            let lat = APICoreData.photos?[i].lat
            let lng = APICoreData.photos?[i].lng
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat!, longitude: lng!))
                marker.map = mapView
            i = i+1
        }
        view = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
