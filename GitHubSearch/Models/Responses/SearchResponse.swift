//
//  SearchResponse.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

struct SearchResponse: Decodable {

    var items: [Repository]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case message = "message"
    }
}
