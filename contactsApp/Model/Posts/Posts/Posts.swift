//
//  Posts.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import CoreData


public class Posts: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var userId: Int16
}
