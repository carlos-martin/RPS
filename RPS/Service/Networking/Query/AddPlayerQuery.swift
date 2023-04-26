//
//  AddPlayerQuery.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import Foundation

struct AddPlayerQuery: Requestable {
    var url: URL
    var parameters: String?
    var method: HTTPMethod = .post

    init(gameId: String, name: String) {
        url = URLConfig.addPlayer(to: gameId)
        parameters = "{\"name\" : \"\(name)\"}"
    }
}
