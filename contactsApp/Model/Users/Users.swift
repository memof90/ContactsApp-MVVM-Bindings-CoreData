//
//  Users.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import CoreData


public class Users: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var phone: String
}
