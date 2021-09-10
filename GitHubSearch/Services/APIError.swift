//
//  APIError.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

enum APIError: Error {
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case conflict               // Status code 409
    case internalServerError    // Status code 500
    case rateLimit
}
