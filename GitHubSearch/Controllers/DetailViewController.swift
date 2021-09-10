//
//  DetailController.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 29..
//

import UIKit

class DetailViewController: UIViewController {
    var contentView : DetailView!
    private var repositoryUrl: String?
    private var repositoryName: String?

    override func loadView() {
        view = contentView
    }

    func configure(url: String, name: String) {
        repositoryUrl = url
        repositoryName = name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = repositoryName
        if let link = URL(string:repositoryUrl ?? "") {
            let request = URLRequest(url: link) 
            contentView.webView.load(request)
        }
    }
    
}
