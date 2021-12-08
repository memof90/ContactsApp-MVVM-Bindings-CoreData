//
//  NetworkServices.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import Foundation


class NetworkServices {
    static let shared = NetworkServices()
    
    let session = URLSession(configuration: .default)
    
    func  fetchUsers(completion: @escaping (()-> Void)) {
        let URL_BASE = Enviroment.getUsers
        guard let url = URL(string: URL_BASE.rawValue) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
//            print(response!)
            do {
//                let json = try JSONSerialization.jsonObject(with: data!)
//                print(json)
            
                let model = try JSONDecoder().decode([UsersServicesModel].self, from: data!)
//                print(model)
                model.forEach { $0.store()}
                
                completion()
                
            } catch {
                
            }
        }
        task.resume()
    }
    
    func fetchPostUser(completion: @escaping (()-> Void)) {
        let URL_BASE = Enviroment.usersId
        guard let url = URL(string: URL_BASE.rawValue) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
//            print(response!)
            do {
                            
                let model = try JSONDecoder().decode([PostServicesModel].self, from: data!)
//                print(model)
                
                model.forEach {
                    $0.store()
                }
                
                completion()
                
            } catch {
                
            }
    
        }
        task.resume()
        
    }
    
    func fetchPostUserId(userId: Int16,completion: @escaping (()-> Void)) {
        let URL_BASE = Enviroment.postId
        guard let url = URL(string: "\(URL_BASE.rawValue)\(userId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
//            print(response!)
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data!)
//                             print(json)
                let model = try JSONDecoder().decode([PostIdServicesModel].self, from: data!)
                print(model)
                
                model.forEach {
                    $0.store()
                }
                
                completion()
            } catch {
                
            }

        }
        task.resume()
    }
}
