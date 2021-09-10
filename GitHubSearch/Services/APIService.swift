//
//  APIService.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import Alamofire
import RxSwift
import RxCocoa

class APIService: APIServiceProtocol {

    private let baseServerUrl = "https://api.github.com"

    private static func request<T: Decodable> (url: URLConvertible,
                                               method: HTTPMethod,
                                               params: [String : String]) -> ResponseObservable<T> {

        return ResponseObservable<T>.create { observer in
            let request = AF.request(url,
                                     method: method,
                                     parameters:params)
                .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let value):
                    observer.onNext((value, response.response?.allHeaderFields))
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(APIError.forbidden)
                    case 404:
                        observer.onError(APIError.notFound)
                    case 409:
                        observer.onError(APIError.conflict)
                    case 500:
                        observer.onError(APIError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func getGithubRepositories(searchTerm: String, page: Int) -> ResponseObservable<SearchResponse> {
        var params = ["q": searchTerm]
        if page > 1 {
            params["page"] = String(page)
        }
        return APIService.request(url: baseServerUrl + "/search/repositories",
                                  method: .get,
                                  params: params)
    }

    func getStargazers(url: String) -> ResponseObservable<[Stargazers]> {
        return APIService.request(url: url, method: .get, params: [:])
    }

}
