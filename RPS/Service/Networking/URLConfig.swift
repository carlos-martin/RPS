//
//  URLConfig.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

struct URLConfig {
    static private let base = "https://rps-api-ujymak7y3a-ew.a.run.app"

    static var allGames: URL {
        URL(string: "\(base)/games")!
    }

    static func game(id: String) -> URL {
        URL(string: "\(base)/games/\(id)")!
    }

    static func round(gameId: String, roundId: String) -> URL {
        URL(string: "\(base)/games/\(gameId)/round/\(roundId)")!
    }

    static var newGame: URL {
        URL(string: "\(base)/games")!
    }

    static func addPlayer(to gameId: String) -> URL {
        URL(string: "\(base)/games/\(gameId)/addPlayer")!
    }

    static func move(to gameId: String) -> URL {
        URL(string: "\(base)/games/\(gameId)/doMove")!
    }
}
