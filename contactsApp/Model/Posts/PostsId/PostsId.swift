//
//  PostsId.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import CoreData

class PostsId: NSManagedObject {
    @NSManaged var userId: Int16
    @NSManaged var id: Int16
    @NSManaged var title: String
    @NSManaged var body: String
}
