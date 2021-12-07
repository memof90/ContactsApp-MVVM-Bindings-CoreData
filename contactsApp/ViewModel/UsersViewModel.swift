//
//  UsersViewModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import UIKit


class UsersViewModels {
    
    static let shared = UsersViewModels()
    var users: [Users]? 
    let database = DatabaseHandler.shared
    
//    MARK: - get Users services
    func getUsers() {
        NetworkServices.shared.fetchUsers {
            self.users = self.database.fetch(Users.self)
        }
    }
    
    func fetchToCoreData() {
        users = database.fetch(Users.self)
    }
    
    func resetCoreData() {
        self.database.reset(Users.self)
    }
    
    
    func numberOfRows(at section: Int) -> Int{
        return users?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> Users {
        return users?[indexPath.row] ?? users![indexPath.row]
    }
    
    
}
