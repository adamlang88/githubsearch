//
//  Stargazers.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

struct Stargazers: Decodable {

    var name: String?

    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
