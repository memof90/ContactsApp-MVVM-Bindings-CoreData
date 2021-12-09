//
//  PostsViewController.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import Foundation
import UIKit


class PostsViewController : UIViewController {
    
    @IBOutlet weak var ContactsDetailsCollectionView: UICollectionView!
    
    
    var didselectHandler: (() -> ())?
    
    var viewModel : userListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactsDetailsCollectionView.delegate = self
        ContactsDetailsCollectionView.dataSource = self
        
        viewModel.users.bind { [weak self] _ in
            
            DispatchQueue.main.async {
                self?.ContactsDetailsCollectionView.reloadData()
            }
            
        }
        
        RegisterNibsCells()
        
        
    }
    
    //    MARK: - RegisterNibsCells
        private func RegisterNibsCells() {
            ContactsDetailsCollectionView.register(UINib(nibName: DetailCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        }
    
}


extension PostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCollectionViewCell.identifier, for: indexPath) as! UsersCollectionViewCell
        
        cell.setupUsers(users: viewModel.users.value![indexPath.row])
        
        cell.seeMoreBtn.isHidden = true
        
        
        return cell
    }
    
    
}
