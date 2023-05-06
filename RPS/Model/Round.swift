//
//  Round.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

struct Round: Codable, JsonConvertable, Equatable {
    let id: String
    var player1Move: MoveOption?
    var player2Move: MoveOption?

    func winner() -> GamePlayerNumber? {
        guard let player1Move = player1Move, let player2Move = player2Move else {
            return nil
        }
        if player1Move == player2Move {
            return nil
        }

        switch (player1Move, player2Move) {
        case (.rock, .scissor), (.paper, .rock), (.scissor, .paper):
            return .one
        default:
            return .two
        }
    }
}
