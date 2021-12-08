//
//  UIViewController+Extension.swift
//  contactsApp
//
//  Created by Memo Figueredo on 7/12/21.
//

import UIKit

extension UIViewController {
//   MARK: - Return name of the viewController class
    static var identifier: String {
        return String(describing:  self)
    }
    
    //   MARK: - Return instance of the viewController class
    static func instance() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        return controller
    }
}
