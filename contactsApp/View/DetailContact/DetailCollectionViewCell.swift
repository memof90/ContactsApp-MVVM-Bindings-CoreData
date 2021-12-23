//
//  DetailCollectionViewCell.swift
//  contactsApp
//
//  Created by Memo Figueredo on 8/12/21.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    //    MARK: - Cell identifier
        static let identifier = String(describing: DetailCollectionViewCell.self)
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var mailLbl: UILabel!
    
    var user: Users? {
        didSet {
            setupData()
        }
    }
    
    
    func setupData() {
        guard let user = user else {return}
        nameLbl.text = user.name
        phoneLbl.text = user.phone
        mailLbl.text = user.email
    }
    
//    MARK: - Options Two Use protocol and delegate
//    func setupDetailPost(users: Users) {
//        nameLbl.text = users.name
//        phoneLbl.text = users.phone
//        mailLbl.text = users.email
//    }
    
    
}
