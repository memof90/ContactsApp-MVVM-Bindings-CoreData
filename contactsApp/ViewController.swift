//
//  ViewController.swift
//  contactsApp
//
//  Created by Memo Figueredo on 6/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    let database = DatabaseHandler.shared
    
    var viewModel = userListViewModel()


    
//    var users: [Users]? {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                self.resetCoreData()
//            }
//        }
//     }
    
     


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UsersTableView")
        tableView.delegate = self
        tableView.dataSource = self

//        getUsers()
//        fetchToCoreData()
//        viewModel.getUsers()
//        viewModel.fetchToCoreData()
        getPost()
        fetchCoreData()
        postId()
        
        viewModel.users.bind { [weak self ] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.viewModel.resetCoreData()
            }
        }
     
    }


    
//    func getUsers(){
//        NetworkServices.shared.fetchUsers {
//            self.users = self.database.fetch(Users.self)
//        }
//
//    }
//
//    func fetchToCoreData() {
//        users = database.fetch(Users.self)
//
//    }
//
//    func resetCoreData() {
//        self.database.reset(Users.self)
//    }
    
    var post: [Posts] = []
    
    func getPost(){
        NetworkServices.shared.fetchPostUser {
            self.post = self.database.fetch(Posts.self)
        }
    }
    
    func fetchCoreData() {
        post = database.fetch(Posts.self)
    }
    
    var potss: [Posts] = []
    
    func postId(){

    
        for posts in post {
            NetworkServices.shared.fetchPostUserId(userId: posts.userId) {
                
        }
           
//            print(array.removingDuplicates())
            
//            print(userId)
            
         
        }
       
    }
    
   
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users?.count ?? 0
//        return viewModel.numberOfRows(at: section)
        return viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UsersTableView")!
        
//        cell.textLabel?.text = users?[indexPath.row].name
        cell.textLabel?.text = viewModel.users.value![indexPath.row].name
        
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

