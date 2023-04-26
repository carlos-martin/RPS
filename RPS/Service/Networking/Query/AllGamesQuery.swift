//
//  AllGamesQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct AllGamesQuery: Requestable {
    var url: URL = URLConfig.allGames
    var parameters: String? = nil
    var method: HTTPMethod = .get
}
