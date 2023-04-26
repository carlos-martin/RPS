//
//  RoundQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct RoundQuery: Requestable {
    var url: URL
    var parameters: String? = nil
    var method: HTTPMethod = .get

    init(gameId: String, roundId: String) {
        url = URLConfig.round(gameId: gameId, roundId: roundId)
    }
}
