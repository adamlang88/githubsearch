//
//  Repository.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

struct Repository: Decodable {

    var owner: Owner?
    var description: String?
    var name: String?
    var stargazersUrl: String?
    var language: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case description = "description"
        case name = "name"
        case stargazersUrl = "stargazers_url"
        case language = "language"
        case url = "html_url"
    }
}
