//
//  SearchCell.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var ownerAvatarHolder: UIView!
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerAvatarIndicator: UIActivityIndicatorView!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    @IBOutlet weak var repoStarCount: UILabel!
    @IBOutlet weak var repoStarIndicator: UIActivityIndicatorView!

    private weak var viewModel: SearchViewModel? = nil
    private let disposeBag = DisposeBag()
    var repositoryUrl: String? = nil
    var repositoryName: String? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.ownerAvatarHolder.layer.cornerRadius = self.ownerAvatarHolder.frame.size.width/2.0
        self.ownerAvatar.layer.cornerRadius = self.ownerAvatar.frame.size.width/2.0
    }

    func bindViewModel(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    func configure(repository: Repository) {
        repositoryUrl = repository.url
        repositoryName = repository.name

        setLabelValue(label: owner, key: "search_result_owner".localized,
                      value: repository.owner?.name)
        setLabelValue(label: repoName, key: "search_result_repository_name".localized,
                      value: repository.name)
        setLabelValue(label: repoDescription, key: "search_result_descriptions".localized,
                      value: repository.description)
        setLabelValue(label: repoLanguage, key: "search_result_programming_language".localized,             value: repository.language)

        getStarCount(starsUrl: repository.stargazersUrl)
        if let url = repository.owner?.avatarUrl {
            loadAvatarImage(avatarUrl: url)
        }
    }

    private func setLabelValue(label: UILabel? ,key: String, value: String?) {
        guard label != nil else {
            return
        }
        let val = value ?? "search_result_no_data".localized
        let attributedText = NSMutableAttributedString()
        attributedText.bold(key)
        attributedText.normal(":")
        attributedText.normal(val)
        label!.attributedText = attributedText
    }

    private func getStarCount(starsUrl: String?) {
        repoStarIndicator.startAnimating()
        repoStarCount.text = ""
        guard let model = viewModel, let url = starsUrl else {
            repoStarCount.text = "search_result_no_data".localized
            repoStarIndicator.stopAnimating()
            return
        }
        model.getStarCount(url: url)
            .subscribe { [weak self] stargazers in
                var value =  String(stargazers.result.count)
                if (stargazers.result.count == 30) {
                    value = "30+"
                }
                self?.setLabelValue(label: self?.repoStarCount,
                                   key: "search_result_stars".localized,
                                   value: value)
                self?.repoStarIndicator.stopAnimating()
            } onError: { [weak self] error in
                switch (error) {
                    case APIError.forbidden:
                    self?.setLabelValue(label: self?.repoStarCount,
                                        key: "search_result_stars".localized,
                                        value: "search_server_error_ratelimit".localized)
                    break
                default:
                    self?.setLabelValue(label: self?.repoStarCount,
                                       key: "search_result_stars".localized,
                                       value: "search_result_stars_network_error".localized)
                }

                self?.repoStarIndicator.stopAnimating()
            }.disposed(by: disposeBag)
    }

    private func loadAvatarImage(avatarUrl: String) {
        ownerAvatarIndicator.startAnimating()
        ownerAvatar.sd_setImage(with: URL.init(string: avatarUrl)) { [weak self] _,_,_,_ in
            self?.ownerAvatarIndicator.stopAnimating()
        }
    }

    func setupShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false

        self.background.layer.cornerRadius = 3.0
        self.background.layer.masksToBounds = true
    }

}
