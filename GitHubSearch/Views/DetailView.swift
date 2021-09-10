//
//  DetailView.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 29..
//

import UIKit
import WebKit

class DetailView: UIView {

    static func instantiate() -> DetailView {
        return initFromNib()
    }

    @IBOutlet weak var webView: WKWebView!
}
