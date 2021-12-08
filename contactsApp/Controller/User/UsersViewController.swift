//
//  UsersViewController.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import UIKit


class UsersViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = userListViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        
        RegisterNibsCells()
        
        viewModel.getUsers()
        viewModel.fetchToCoreData()
        viewModel.resetCoreData()
        
        
        viewModel.users.bind { [weak self ] _ in
            DispatchQueue.main.async {
                self?.userCollectionView.reloadData()
            }
        }
        userCollectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    
//    MARK: - Search Bar
    //   MARK: - SearchBar Message to the data not appareance
        fileprivate let searchController = UISearchController(searchResultsController: nil)
        fileprivate let enterSearchTermLabel: UILabel = {
                let label = UILabel()
                label.text  = "Empty List"
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filterContentForSearchText(searchText: searchText)
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
           
        })
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText != "" {
            
            viewModel.searchUsers.value = viewModel.users.value?.filter{ name in
                return name.name.lowercased().contains(searchText.lowercased())
                }
       }  else {
                self.viewModel.searchUsers.value = self.viewModel.users.value!
           }
            
        }
    
    
    
//    MARK: - RegisterNibsCells
    private func RegisterNibsCells() {
        userCollectionView.register(UINib(nibName: UsersCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: UsersCollectionViewCell.identifier)
    }
    
}




extension UsersViewController: UICollectionViewDelegate,
                               UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
        return viewModel.numberOfRows(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCollectionViewCell.identifier, for: indexPath) as! UsersCollectionViewCell
        
//        cell.nameLbl.text = viewModel.item(at: indexPath).name
        
        cell.setupUsers(users: viewModel.item(at: indexPath))
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        return cell
    }
    
    
}
