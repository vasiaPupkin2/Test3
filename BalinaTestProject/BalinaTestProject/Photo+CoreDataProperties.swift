//
//  Photo+CoreDataProperties.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 05.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double

}
