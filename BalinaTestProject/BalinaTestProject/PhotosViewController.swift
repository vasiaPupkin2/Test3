//
//  PhotosViewController.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 04.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit
import SWRevealViewController
import CoreLocation

class PhotosViewController: UIViewController ,UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate  {
    
    let cellId = "photoCell"
    let selecdedRow = "selectedRow" //UserDefaults
    let locationManager = CLLocationManager()
    let pickerController = UIImagePickerController()
    let formatter = DateFormatter()
    
    var currentLocation : CLLocationCoordinate2D?
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK : Adding photo to Core Data
    @IBAction func addPhoto(_ sender: Any) {
        let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.openCamera()
        })
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
            self.openGallary()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        alertViewController.addAction(camera)
        alertViewController.addAction(gallery)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            pickerController.delegate           = self
            self.pickerController.sourceType    = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing      = true
            self .present(self.pickerController, animated: true, completion: nil)
        }
        else {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            pickerController.delegate       = self
            pickerController.sourceType     = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing  = true
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    //MARK : Save image to Core Data
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        APICoreData.savePhoto(locaton: currentLocation!, photoData: UIImagePNGRepresentation(image) as! Data)
            dismiss(animated:true, completion: nil)
            collectionView.reloadData()
    }
    
    func setNavigationBar(){
        let revalController = SWRevealViewController()
        self.navigationController?.navigationBar.addGestureRecognizer(revalController.panGestureRecognizer())
        let revealButtonItem = UIBarButtonItem(image: UIImage(named : "reveal-icon"), style: .bordered, target: revalController, action: #selector(SWRevealViewController.revealToggle(_:)))
        
        self.navigationItem.leftBarButtonItem = revealButtonItem
        self.navigationItem.title = "Photos"
        
    }
    //MARK : Get location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource   = self
        collectionView.delegate     = self
        pickerController.delegate   = self
        locationManager.delegate    = self;
        self.navigationController?.navigationBar.barTintColor =  UIColor(colorLiteralRed: 0.57, green: 0.8, blue: 0.3, alpha: 1 )
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        setNavigationBar()
        
        collectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
       
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}


extension PhotosViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return APICoreData.photos?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoCollectionViewCell
        let image = UIImage(data: APICoreData.photos?[indexPath.row].photo as! Data)
        cell.photoImage.image   = image
        formatter.dateFormat    = "dd-MM-yyyy"
        cell.photoDate.text     = formatter.string(from: (APICoreData.photos?[indexPath.row].date)! as Date)
        
        return cell
    }
}


extension PhotosViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UserDefaults.standard.set(indexPath.row, forKey: selecdedRow)
        self.show(DetailPhotoViewController(), sender: nil )
        
    }
    
    
    
    
}
