//
//  Request.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

protocol Requestable {
    var url: URL { get }
    var parameters: String? { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"

    var value: String {
        rawValue
    }
}

enum HTTPStatusResponse {
    case success(Int)
    case redirection(Int)
    case clientError(Int)
    case serverError(Int)
    case undefined

    var description: String {
        switch self {
        case .success(let statusCode):
            return "Success (\(statusCode))"
        case .redirection(let statusCode):
            return "Redirection (\(statusCode))"
        case .clientError(let statusCode):
            return "Client Error (\(statusCode))"
        case .serverError(let statusCode):
            return "Server Error (\(statusCode))"
        case .undefined:
            return "Undefined"
        }
    }

    init(_ statusCode: Int) {
        switch statusCode {
        case 200...299:
            self = .success(statusCode)
        case 300...399:
            self = .redirection(statusCode)
        case 400...499:
            self = .clientError(statusCode)
        case 500...599:
            self = .serverError(statusCode)
        default:
            self = .undefined
        }
    }
}
