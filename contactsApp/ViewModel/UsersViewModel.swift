//
//  UsersViewModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation
import UIKit


class userListViewModel {
    
    let database = DatabaseHandler.shared
    
    var users: Observable<[Users]> = Observable([])
    
    var searchUsers: Observable<[Users]> = Observable([])
    
    var filter = false

    
  
    func getUsers() {
        NetworkServices.shared.fetchUsers {
            self.users.value = self.database.fetch(Users.self)
        }
    }
    
    func fetchToCoreData() {
        users.value = database.fetch(Users.self)
    }
    
    func resetCoreData() {
        self.database.reset(Users.self)
    }
    
    func numberOfRows(at section: Int, searchController: UISearchController, entersearchLabel: UILabel) -> Int{
        if searchController.isActive {
            entersearchLabel.isHidden = filter ? users.value?.count ?? 0 == 0 :  searchUsers.value?.count ?? 0 != 0
            return filter ? users.value?.count ?? 0
            : searchUsers.value?.count ?? 0
        } else {
            entersearchLabel.isHidden = true
           return  users.value?.count ?? 0
        }
        
    }
    
    func item(at indexPath: IndexPath, searchController: UISearchController) -> Users {
        
        if searchController.isActive {
            return filter ?  users.value![indexPath.row] : searchUsers.value![indexPath.row]
        } else {
            return users.value![indexPath.row]
        }

        
    }
}




