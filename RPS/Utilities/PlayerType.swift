//
//  PlayerType.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import Foundation

enum PlayerType {
    case player1(Player?)
    case player2(Player?)

    var title: String {
        switch self {
        case .player1:
            return "Player 1"
        case .player2:
            return "Player 2"
        }
    }

    var name: String {
        switch self {
        case .player1(let player):
            return player?.name ?? "No player"
        case .player2(let player):
            return player?.name ?? "No player"
        }
    }
}
