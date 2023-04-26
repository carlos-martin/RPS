//
//  Queries.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

struct AllGamesQuery: Requestable {
    var url: URL = URLConfig.allGames
    var parameters: String? = nil
    var method: HTTPMethod = .get
}

struct GameQuery: Requestable {
    var url: URL
    var parameters: String? = nil
    var method: HTTPMethod = .get

    init(gameId: String) {
        url = URLConfig.game(id: gameId)
    }
}

struct RoundQuery: Requestable {
    var url: URL
    var parameters: String? = nil
    var method: HTTPMethod = .get

    init(gameId: String, roundId: String) {
        url = URLConfig.round(gameId: gameId, roundId: roundId)
    }
}

struct NewGameQuery: Requestable {
    var url: URL = URLConfig.newGame
    var parameters: String? = nil
    var method: HTTPMethod = .post
}

struct AddPlayerQuery: Requestable {
    var url: URL
    var parameters: String?
    var method: HTTPMethod = .post

    init(gameId: String, name: String) {
        url = URLConfig.addPlayer(to: gameId)
        parameters = "{\"name\" : \"\(name)\"}"
    }
}

struct GameMoveQuery: Requestable {
    var url: URL
    var parameters: String?
    var method: HTTPMethod = .post

    init(gameId: String, move: Move) {
        url = URLConfig.move(to: gameId)
        parameters = move.toJson()
    }
}
