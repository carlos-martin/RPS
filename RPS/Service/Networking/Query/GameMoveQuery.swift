//
//  GameMoveQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct GameMoveQuery: Requestable {
    var url: URL
    var parameters: String?
    var method: HTTPMethod = .post

    init(gameId: String, move: Move) {
        url = URLConfig.move(to: gameId)
        printlog("url: \(url)")
        parameters = move.toJson()
        printlog("parameters: \(parameters ?? "<empty>")")
    }
}
