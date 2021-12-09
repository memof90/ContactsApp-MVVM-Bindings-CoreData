//
//  UsersCollectionViewCell.swift
//  contactsApp
//
//  Created by Memo Figueredo on 7/12/21.
//

import UIKit

class UsersCollectionViewCell: UICollectionViewCell {
    
    
//    MARK: - Cell identifier
    static let identifier = String(describing: UsersCollectionViewCell.self)

    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var mailLbl: UILabel!
    
    @IBOutlet weak var seeMoreBtn: UIButton!
    
    var didselectHandler: (() -> ())?
   
    @IBAction func pushMoreBtn(_ sender: Any) {
        didselectHandler?()
        print("funciona")
    }
    
    func setupUsers(users: Users){
        nameLbl.text = users.name
        phoneLbl.text = users.phone
        mailLbl.text = users.email
    }
    
    
}
