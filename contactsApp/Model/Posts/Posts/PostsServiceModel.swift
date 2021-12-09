//
//  PostsServiceModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import Foundation
import CoreData

struct PostServicesModel: Codable {
    let userId: Int
    let id: Int
    
    static let database = DatabaseHandler.shared
    
    
    func store() {
        guard let posts = PostServicesModel.database.add(Posts.self) else {return}
        
        
        posts.id = Int16(id)
        posts.userId = Int16(userId)
      
        
        
        PostServicesModel.database.save()
    }
    
    
}
