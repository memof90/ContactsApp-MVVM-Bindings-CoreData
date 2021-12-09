//
//  PostsIdServiceModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import Foundation
import CoreData

struct PostIdServicesModel : Codable {
    let userId: Int
    let id: Int
    let title : String
    let body: String
    
    static let database = DatabaseHandler.shared
    
    func store() {
        
        
        guard let postsId = PostIdServicesModel.database.add(PostsId.self) else {return}
        

        
        postsId.userId = Int16(userId)
        postsId.id = Int16(id)
        postsId.title = title
        postsId.body = body
        
        
        PostIdServicesModel.database.save()
        
    }
}
