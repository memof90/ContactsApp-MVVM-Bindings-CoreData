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
    
    func didSelectItemAt(at collectionView: UICollectionView,  didSelectItemAt indexPath: IndexPath, with navigationController: UINavigationController, searchController: UISearchController ) {
        if searchController.isActive {
            let itemDetail = filter ? users.value![indexPath.row] : searchUsers.value![indexPath.row]
            let controller = PostsViewController.instance()
            controller.viewModel = itemDetail
            navigationController.pushViewController(controller, animated: true)
        } else {
            let controller = PostsViewController.instance()
            controller.viewModel = users.value![indexPath.row]
            navigationController.pushViewController(controller, animated: true)
        }
      
        
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

//struct userViewModel {
//     let id: Int
//     let name: String
//     let email: String
//     let phone: String
//    
//    init(user: Users) {
//        self.id = Int(user.id)
//        self.name = user.name
//        self.email = user.email
//        self.phone = user.phone
//    }
//}


