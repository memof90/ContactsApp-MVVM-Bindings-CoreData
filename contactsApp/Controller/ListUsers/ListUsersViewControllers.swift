//
//  ListUsersViewControllers.swift
//  contactsApp
//
//  Created by Memo Figueredo on 7/12/21.
//

import Foundation
import UIKit

class ListUsersViewControllers: BaseListController, UICollectionViewDelegateFlowLayout {
    
    //    MARK:- Identifier Cell
    fileprivate let cellId = "id1234"
    
//    MARK: ViewModel
    var viewModel = userListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
//        MARK: - Register cell
        collectionView.register(ListUserCell.self, forCellWithReuseIdentifier: cellId)
        viewModel.getUsers()
        viewModel.fetchToCoreData()
        
        viewModel.users.bind { [weak self ] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.viewModel.resetCoreData()
            }
        }
    }
}

extension ListUsersViewControllers {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return .init(width: view.frame.width, height: 350)
     }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListUserCell
        
        cell.nameLabel.text = viewModel.item(at: indexPath).name
        return cell
    }
    
}
