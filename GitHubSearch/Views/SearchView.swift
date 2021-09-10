//
//  SearchView.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit

class SearchView: UIView {

    static func instantiate() -> SearchView {
        return initFromNib()
    }

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.placeholder = "search_bar_placeholder".localized
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.setTitle("search_next".localized, for: .normal)
        }
    }
    @IBOutlet weak var prevButton: UIButton! {
        didSet {
            self.prevButton.setTitle("search_prev".localized, for: .normal)
        }
    }

    @IBOutlet weak var pagingInfoLabel: UILabel!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pagingViewHeightConstant: NSLayoutConstraint!

}
