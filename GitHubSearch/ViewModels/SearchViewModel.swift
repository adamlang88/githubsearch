//
//  SearchViewModel.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    var dataRepository : DataRepository!

    var repositoryData = PublishSubject<[Repository]>()
    var repositoryDataError = PublishSubject<Error>()
    var repositoryDataLoading = PublishSubject<Bool>()
    var repositoryDataPagingParams = PublishSubject<(Int,Int,Int)>()

    private let disposeBag = DisposeBag()

    func refreshData(searchTerm: String, page: Int = 0) {
        repositoryDataLoading.onNext(true)
        dataRepository.getGithubRepositories(searchTerm: searchTerm, page: page)
            .subscribe { [weak self] response in
                self?.repositoryDataLoading.onNext(false)
                if let message = response.result.message {
                    if message.contains("API rate limit exceeded") {
                        self?.repositoryDataError.onNext(APIError.rateLimit)
                        self?.repositoryDataPagingParams.onNext((-1,-1,-1))
                        return
                    }
                }
                if let result = response.result.items {
                    self?.repositoryData.onNext(result)
                    self?.repositoryDataPagingParams.onNext(
                        self?.getPagingParams(headers: response.headers) ?? (-1,-1,-1))
                } else {
                    self?.repositoryData.onNext([])
                    self?.repositoryDataPagingParams.onNext((-1,-1,-1))
                }
            } onError: { [weak self] error in
                self?.repositoryDataError.onNext(error)
            }.disposed(by: disposeBag)
    }

    func getStarCount(url: String) -> ResponseObservable<[Stargazers]> {
        return dataRepository.getStargazers(url: url)
    }

    func getPagingParams(headers: [AnyHashable : Any]?) -> (Int,Int, Int) {
        guard let values = headers,
              let links = values["Link"] as? String else {
            return (-1,-1,-1)
        }

        let next = indexByKey(pagingString: links, key: "next")
        let last = indexByKey(pagingString: links, key: "last")
        let prev = indexByKey(pagingString: links, key: "prev")

        return (next,last,prev)
    }

    fileprivate func indexByKey(pagingString: String ,key: String) -> Int {
        let comps = pagingString.components(separatedBy: key)
        if comps.count < 2 {
            return -1
        }
        let parts = comps.first!.components(separatedBy: "page=")
        if parts.count < 2 {
            return -1
        }
        let cutEnd1 = parts.last!.components(separatedBy: ">").first
        let cutEnd2 = cutEnd1?.components(separatedBy: "&").first
        let value = cutEnd2 ?? "-1"
        return Int(value) ?? -1
    }

}
