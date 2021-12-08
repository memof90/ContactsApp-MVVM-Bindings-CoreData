//
//  UsersViewController.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import UIKit


class UsersViewController: UIViewController {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
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
        
        return cell
    }
    
    
}
