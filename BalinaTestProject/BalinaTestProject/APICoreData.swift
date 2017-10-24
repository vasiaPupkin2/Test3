//
//  APICoreData.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 05.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class APICoreData  {
    
    private static var managedContext : NSManagedObjectContext {
        get {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return (appDelegate?.persistentContainer.viewContext)!
        }
    }
    
    public static var photos : [Photo]? {
        get{
            let request = NSFetchRequest<Photo>(entityName : "Photo")
            do {
                return try managedContext.fetch(request)
                
            } catch let error as NSError {
                print("Fetching error: \(error), \(error.userInfo)")
            }
            return nil
        }
    }
    
    
    public static func savePhoto(locaton : CLLocationCoordinate2D, photoData : Data){
        
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: self.managedContext) as! Photo
        
        photo.lat       = locaton.latitude
        photo.lng       = locaton.longitude
        photo.date      = Date() as NSDate
        photo.photo     = photoData as NSData
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

      
        
    }
 
 
}
