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
                print(error.localizedDescription)
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
//                print(String(data: data!, encoding: .utf8)!)
                
//                let json = try JSONSerialization.jsonObject(with: data!) as! [[String: AnyObject]]
//                print(json.count)
                            
                
                let model = try JSONDecoder().decode([PostServicesModel].self, from: data!)
                
               
                model.forEach {
                    $0.store()
                }
                
                completion()
                
            } catch {
                print(error.localizedDescription)
            }
    
        }
        task.resume()
        
    }
    
    
    
    func fetchPost(completion: @escaping (PostModel? , Error?) -> ()) {
        let URL_BASE = Enviroment.usersId
        guard let url = URL(string: URL_BASE.rawValue) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = session.dataTask(with: request) { data, response, err in
//            print(String(data: data!, encoding: .utf8)!)
            //            error to requets
                        if let err = err {
                            print("Failed to fetch apps:", err)
                            completion([], nil)
                            return
                        }
                guard let data = data else { return }
            
            do {
                let postId = try JSONDecoder().decode(PostModel.self, from: data)
                
              
                completion(postId, nil)
                
                
                
            } catch let jsonErr {
                debugPrint("Failed to decode json:", jsonErr)
                completion([], jsonErr)
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
//                print(model)
                
                model.forEach {
                    $0.store()
                }
                
                completion()
            } catch {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
}
