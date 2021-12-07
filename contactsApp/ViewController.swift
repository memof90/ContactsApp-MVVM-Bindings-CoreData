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
    
//    lazy  var users = UsersViewModels.shared.users
    
    var users: [Users]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.resetCoreData()
            }
           
        }
     }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UsersTableView")
        tableView.delegate = self
        tableView.dataSource = self
        
//        UsersViewModels.shared.getUsers()
//        UsersViewModels.shared.fetchToCoreData()
        getUsers()
        fetchToCoreData()
     
    }


    
    func getUsers(){
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
    
   
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UsersTableView")!
        
        cell.textLabel?.text = users?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

