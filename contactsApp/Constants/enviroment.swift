//
//  enviroment.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation


class Enviroment {
    static let getUsers = APIPath.getUsers
    static let usersId = APIPath.userId
    static let postId = APIPath.postList

    
    enum APIPath : String {
    case getUsers = "https://jsonplaceholder.typicode.com/users"
    case userId = "https://jsonplaceholder.typicode.com/posts"
    case postList = "https://jsonplaceholder.typicode.com/posts?userId="
    }
}
