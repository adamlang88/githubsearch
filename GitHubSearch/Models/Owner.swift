//
//  Owner.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

struct Owner: Decodable {

    var avatarUrl: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case name = "login"
    }
}
