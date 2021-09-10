//
//  SearchViewController.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    var searchView : SearchView!
    var viewModel : SearchViewModel!
    private let disposeBag = DisposeBag()
    var actualPage = 0

    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "search_title".localized
        setupBinding()
        viewModel.refreshData(searchTerm: "")
    }

    func setupBinding() {
        let cellId = String(describing: SearchCell.self)
        let cellNib = UINib(nibName: cellId, bundle: nil)
        searchView.collectionView.register(cellNib,forCellWithReuseIdentifier: cellId)
        searchView.collectionView.delegate = self

        viewModel.repositoryData.bind(to: searchView.collectionView.rx.items(cellIdentifier: cellId, cellType: SearchCell.self)) {  (row,item,cell) in
                cell.bindViewModel(viewModel: self.viewModel)
                cell.configure(repository: item)
            }.disposed(by: disposeBag)

        viewModel.repositoryDataLoading
            .subscribe(onNext: { [weak self] loading in
                if loading {
                    self?.searchView.infoLabel.text = ""
                    self?.searchView.collectionView.isHidden = true
                    self?.searchView.loadingIndicator.startAnimating()
                } else {
                    self?.searchView.collectionView.isHidden = false
                    self?.searchView.loadingIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)

        viewModel.repositoryData
            .subscribe(onNext: { [weak self] data in
                let actualFilter = self?.searchView.searchBar.text ?? ""
                if data.count == 0 {
                    if actualFilter.isEmpty {
                        self?.searchView.infoLabel.text = "search_result_initial".localized
                    } else {
                        self?.searchView.infoLabel.text = "search_no_results".localized
                    }
                }
                self?.searchView.collectionView.isHidden = data.count == 0
            }).disposed(by: disposeBag)

        viewModel.repositoryDataError
            .subscribe(onNext: { [weak self] error in
                self?.searchView.collectionView.isHidden = true
                let actualFilter = self?.searchView.searchBar.text ?? ""
                if actualFilter.isEmpty {
                    self?.searchView.infoLabel.text = "search_result_initial".localized
                    return
                }
                switch (error) {
                    case APIError.rateLimit:
                    self?.searchView.infoLabel.text = "search_server_error_ratelimit".localized
                    break
                default:
                    self?.searchView.infoLabel.text = "search_server_error".localized
                }
            }).disposed(by: disposeBag)

        viewModel.repositoryDataPagingParams
            .subscribe(onNext: { [weak self] (next,last, prev) in
                if next > 0 {
                    self?.actualPage = next-1
                } else {
                    self?.actualPage = prev+1
                }
                var lastPage = last
                let pagingShouldShow = (last > 1 || prev > 0)
                if lastPage == -1 {
                    lastPage = self?.actualPage ?? 0
                }
                self?.searchView.pagingViewHeightConstant.constant = pagingShouldShow ? 40.0 : 0.0
                self?.searchView.layoutIfNeeded()
                self?.searchView.pagingInfoLabel.text = String(format: "(%i/%i)",self?.actualPage ?? 0,lastPage)
                self?.searchView.prevButton.isEnabled = (next != 2)
                self?.searchView.prevButton.isUserInteractionEnabled = (next != 2)
                self?.searchView.nextButton.isEnabled = (self?.actualPage != lastPage)
                self?.searchView.nextButton.isUserInteractionEnabled = (self?.actualPage != last)
            }).disposed(by: disposeBag)


        searchView.searchBar.rx.text
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] filter in
                self?.viewModel.refreshData(searchTerm: filter ?? "", page: 0)
            })
            .disposed(by: disposeBag)

        searchView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.actualPage+=1
                self?.viewModel.repositoryDataLoading.onNext(true)
                self?.viewModel.refreshData(searchTerm:self?.searchView.searchBar.text ?? "", page: self?.actualPage ?? 0)
            })
            .disposed(by: disposeBag)

        searchView.prevButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.actualPage-=1
                self?.viewModel.repositoryDataLoading.onNext(true)
                self?.viewModel.refreshData(searchTerm:self?.searchView.searchBar.text ?? "", page: self?.actualPage ?? 0)
            })
            .disposed(by: disposeBag)

    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if searchView.searchBar.isFirstResponder {
            searchView.searchBar.resignFirstResponder()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let cell = searchView.collectionView.cellForItem(at: indexPath) as? SearchCell,
           let url = cell.repositoryUrl, let name = cell.repositoryName {
            let detail = Injector.resolve(DetailViewController.self)!
            detail.configure(url: url, name: name)
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }

}
