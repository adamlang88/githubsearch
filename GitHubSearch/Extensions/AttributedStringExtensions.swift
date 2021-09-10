//
//  AttributedStringExtensions.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit

extension NSMutableAttributedString {

    var fontSize: CGFloat { return 12 }
    var boldFont: UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont: UIFont { return UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont,
            .foregroundColor: UIColor.gray,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
    }

    func normal(_ value:String) {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
            .foregroundColor: UIColor.gray,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
    }
    
}
