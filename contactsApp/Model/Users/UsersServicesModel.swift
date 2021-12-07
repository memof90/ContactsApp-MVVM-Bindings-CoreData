//
//  UsersServicesModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import CoreData

struct UsersServicesModel: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    
    static let database = DatabaseHandler.shared
    
    func store() {
        guard let users = UsersServicesModel.database.add(Users.self) else {return}
        
//        let id = users.id
////        if id == 0 {return}
//        let predicate = NSPredicate.init(format: "id == %@", id)
//        guard let isSaved = UsersServicesModel.database.isEntrySaved(entity: "Users", predicate: predicate) else {return}
//        if isSaved {return}
        
        
        users.id = Int16(id)
        users.name = name
        users.email = email
        users.phone = phone
        
        
        UsersServicesModel.database.save()
    
        
  
    }
    
    
}
