//
//  GameQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct GameQuery: Requestable {
    var url: URL
    var parameters: String? = nil
    var method: HTTPMethod = .get

    init(gameId: String) {
        url = URLConfig.game(id: gameId)
    }
}
