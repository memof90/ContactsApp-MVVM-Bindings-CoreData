//
//  PostsCollectionViewCell.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    
    //    MARK: - Cell identifier
        static let identifier = String(describing: PostsCollectionViewCell.self)

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var DescriptionLbl: UILabel!
    
    
    func setupUserId(userId: PostsId) {
        titleLbl.text = userId.title
        DescriptionLbl.text = userId.body
    }
    
}
