//
//  PostViewModel.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import Foundation
import UIKit

class PostsListViewModel {
    let database = DatabaseHandler.shared
    
    var post: [Posts] = []
    
    var postsId: Observable<[PostsId]> = Observable([])
    
    func getPost(){
        NetworkServices.shared.fetchPostUser {
            DispatchQueue.main.async {
                self.post = self.database.fetch(Posts.self)
            }
        }
    }
    
    func fetchToCoreDataPost() {

            post = self.database.fetch(Posts.self)
        
        
    }
    
    func resetCoreDataPost() {
        
            database.reset(Posts.self)
        
        
    }
    
    func getPostId() {
    
            NetworkServices.shared.fetchPostUserId(userId: 1) {
                        DispatchQueue.main.async {
                            self.postsId.value = self.database.fetch(PostsId.self)
                        }
                       
                    }
    }
    
    func fetchToCoreDataPostId(){
   
            postsId.value = database.fetch(PostsId.self)
        
        
    }
    
    func resetCoreDataPostId() {
       
            database.reset(PostsId.self)
        
       
    }
    
    func collectionViewNumberOfItemsInSection(_ collectionView: UICollectionView, usersCollectionViewCell: UICollectionView, postCollectionViewCell: UICollectionView) -> Int {
        switch collectionView {
        case usersCollectionViewCell :
            return 1
        case postCollectionViewCell:
            return postsId.value?.count ?? 0
        default:
           return 0
        }
    }
    
    func collectionViewcellForItemAt(_ collectionView: UICollectionView,usersCollectionViewCell: UICollectionView, postCollectionViewCell: UICollectionView, viewModel: userListViewModel , ActivityIndicator: UIActivityIndicatorView ,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        switch collectionView {
        case usersCollectionViewCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
            
            cell.setupDetailPost(users: viewModel.users.value![indexPath.row])
            
            return cell
        
        case postCollectionViewCell:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCollectionViewCell.identifier , for: indexPath) as!  PostsCollectionViewCell
            if postsId.value?.count ?? 0 > 0 && indexPath.row < postsId.value?.count ?? 0 {
                
                cell.setupUserId(userId: postsId.value![indexPath.row])
                ActivityIndicator.stopAnimating()
                ActivityIndicator.isHidden = true
            }
            
            
            return cell
            
            
        default:
          return UICollectionViewCell()
            
        }

    }
}
