//
//  UIView+Extension.swift
//  contactsApp
//
//  Created by Memo Figueredo on 7/12/21.
//

import Foundation
import UIKit


extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}


