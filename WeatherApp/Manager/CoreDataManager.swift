//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 03/01/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func getStoredLocations() -> [Location] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [Location]()
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoredLocation")
        var storedLocations: [NSManagedObject] = []
        do {
            storedLocations = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var locations = [Location]()
        for storedLocation in storedLocations {
            let location = Location.init(lat: storedLocation.value(forKey: "lat") as! String, lon: storedLocation.value(forKey: "lon") as! String)
            
            locations.append(location)
        }
        
        return locations
    }
    
    func saveLocation(lat: String, lon: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "StoredLocation", in: managedContext)!
        let storedLocation = NSManagedObject(entity: entity, insertInto: managedContext)
        storedLocation.setValue(lat, forKeyPath: "lat")
        storedLocation.setValue(lon, forKeyPath: "lon")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllLocations() -> Bool {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredLocation")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            return true
        } catch let error as NSError {
            print("Deleted all my data in StoredLocation error : \(error) \(error.userInfo)")
            return false
        }
    }
}

