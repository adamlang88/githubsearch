//
//  UIView+Init.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit

extension UIView {

    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
}
