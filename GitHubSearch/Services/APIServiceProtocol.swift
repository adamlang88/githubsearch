//
//  APIServiceProtocol.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 09. 08..
//

import Foundation
import RxCocoa
import RxSwift

typealias ResponseObservable<T> = Observable<(result: T, headers: [AnyHashable : Any]?)>

protocol APIServiceProtocol {
    func getGithubRepositories(searchTerm: String, page: Int) -> ResponseObservable<SearchResponse>
    func getStargazers(url: String) -> ResponseObservable<[Stargazers]>
}
