//
//  NewGameQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct NewGameQuery: Requestable {
    var url: URL = URLConfig.newGame
    var parameters: String? = nil
    var method: HTTPMethod = .post
}
