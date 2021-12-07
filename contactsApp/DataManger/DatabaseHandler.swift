//
//  DatabaseHandler.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import CoreData
import UIKit


// MARK: - Database Local File Configuration
class DatabaseHandler {
    //    MARK: - viewcontext to save Core Data
    private var viewContext : NSManagedObjectContext!
    //    MARK: - Singleton to share to controller
    static let shared = DatabaseHandler()
    //    MARK: - Allow that apliaction save data in local Device with coreData
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.viewContext.automaticallyMergesChangesFromParent = false
        self.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }

    //    MARK: - Fuction add objects to core Data
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    //    MARK: - Fuction Feth data objects to coredata to controllers and Views
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
    
        do {
            let result = try viewContext.fetch(request)
            
            
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
       
    }
    
    
    func isEntrySaved(entity name: String, predicate: NSPredicate) -> Bool? {
      
      // Perform search
      let entityForTableName = NSEntityDescription.entity(forEntityName: name, in: viewContext)
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
      fetchRequest.predicate = predicate
      fetchRequest.entity = entityForTableName
      do {
        let results = try viewContext.fetch(fetchRequest)
        return !results.isEmpty
      } catch {
        //print(error.localizedDescription)
      }
      return nil
    }
        
    
        
    //    MARK: - Fuction Search objects to core Data
    func fetchSearch<T: NSManagedObject>(search: String, _ type: T.Type, entityName: String) -> [T] {
        var predicate: NSPredicate = NSPredicate()
        predicate = NSPredicate(format: "title == %@", search)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    //    MARK: - Fuction Save objects to core Data
    func save() {
        viewContext.perform {
            do {
                try self.viewContext.save()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //    MARK: - Fuction Remove  objects to core Data Next Realease app
    
    func delete<T: NSManagedObject>(object: T) {
        viewContext.delete(object)
        save()
    }
    
    
    func reset<T: NSManagedObject>(_ object: T.Type) {
        fetch(object).forEach{
            delete(object: $0)
        }
       
    }
    
}
