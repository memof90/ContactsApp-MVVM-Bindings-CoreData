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
    
    @IBOutlet weak var postIdCollectionView: UICollectionView!
    
    
    @IBOutlet weak var LoadingData: UIActivityIndicatorView!
    
    var didselectHandler: (() -> ())?
    
    var viewModel : userListViewModel!
    
    private var locationTimer: Timer?
    private var saveTimer: Timer?
    
    var viewModelPost  = PostsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactsDetailsCollectionView.delegate = self
        ContactsDetailsCollectionView.dataSource = self
        
        postIdCollectionView.delegate = self
        postIdCollectionView.dataSource = self
        

        viewModelPost.postsId.bind { [weak self] _ in
            
            DispatchQueue.main.async {
                    self?.postIdCollectionView.reloadData()
            }
        
        }
       
//        self.viewModelPost.getPost()
//        self.viewModelPost.fetchToCoreDataPost()
        
        
            self.viewModelPost.getPostId()
            self.viewModelPost.fetchToCoreDataPostId()
//            self.viewModelPost.resetCoreDataPostId()
        
        

       
        
        RegisterNibsCells()
        
        LoadingData.startAnimating()
        LoadingData.isHidden = false
        
        
    }
    
    
    //    MARK: - RegisterNibsCells
        private func RegisterNibsCells() {
            ContactsDetailsCollectionView.register(UINib(nibName: DetailCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
            
            postIdCollectionView.register(UINib(nibName: PostsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PostsCollectionViewCell.identifier)
            
        }
    
}


extension PostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelPost.collectionViewNumberOfItemsInSection(collectionView, usersCollectionViewCell: ContactsDetailsCollectionView, postCollectionViewCell: postIdCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        return viewModelPost.collectionViewcellForItemAt(collectionView, usersCollectionViewCell: ContactsDetailsCollectionView, postCollectionViewCell: postIdCollectionView, viewModel: viewModel, ActivityIndicator: LoadingData ,cellForItemAt: indexPath)
        
     
    }
    
    
}
