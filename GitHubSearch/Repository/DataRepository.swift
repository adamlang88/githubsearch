//
//  DataRepository.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import RxSwift
import RxCocoa

protocol DataRepositoryProtocol {
    func getGithubRepositories(searchTerm: String, page: Int) -> ResponseObservable<SearchResponse>
    func getStargazers(url: String) -> ResponseObservable<[Stargazers]>
}

class DataRepository {
    var apiService : APIServiceProtocol!
}

extension DataRepository : DataRepositoryProtocol {

    func getGithubRepositories(searchTerm: String, page: Int) -> ResponseObservable<SearchResponse> {
        apiService.getGithubRepositories(searchTerm: searchTerm, page: page)
    }

    func getStargazers(url: String) -> ResponseObservable<[Stargazers]> {
        apiService.getStargazers(url: url)
    }

}
