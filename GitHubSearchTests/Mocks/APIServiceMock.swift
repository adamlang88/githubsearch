//
//  APIServiceMock.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 29..
//

import RxSwift
import RxCocoa

class APIServiceMock: APIServiceProtocol {

    func getGithubRepositories(searchTerm: String, page: Int = 0) -> ResponseObservable<SearchResponse> {

        let owner = Owner(avatarUrl: "https://www.gstatic.com/webp/gallery3/1.png",
                          name: "Test owner")

        let repo1 = Repository(owner: owner,
                               description: "desc1",
                               name: "name1",
                               stargazersUrl: "http://www.google.com",
                               language: "lang1",
                               url: "http://www.google.com")

        let repo2 = Repository(owner: owner,
                               description: "desc2",
                               name: "name2",
                               stargazersUrl: "http://www.google.com",
                               language: "lang2",
                               url: "http://www.google.com")

        let searchResponse = SearchResponse(items: [repo1,repo2], message: nil)

        if searchTerm.isEmpty {
            return ResponseObservable.just((SearchResponse(), nil))
        }
        if searchTerm == "apierror" {
            return ResponseObservable.just((SearchResponse(items: [], message: "API rate limit exceeded"), nil))
        }

        return ResponseObservable.just((searchResponse, nil))
    }

    func getStargazers(url: String) -> ResponseObservable<[Stargazers]> {
        let star1 = Stargazers(name: "a")
        let star2 = Stargazers(name: "b")
        return ResponseObservable.just(([star1, star2], nil))
    }


}
