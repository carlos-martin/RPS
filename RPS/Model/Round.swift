//
//  Round.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

struct Round: Codable, JsonConvertable {
    let id: String
    var player1Move: MoveOption?
    var player2Move: MoveOption?
}
