//
//  PlayerNumber.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import Foundation

enum PlayerNumber {
    case one(Player?=nil)
    case two(Player?=nil)

    var description: String {
        switch self {
        case .one:
            return "Player 1"
        case .two:
            return "Player 2"
        }
    }

    var name: String {
        switch self {
        case .one(let player):
            return player?.name ?? "No player"
        case .two(let player):
            return player?.name ?? "No player"
        }
    }

    var player: Player? {
        switch self {
        case .one(let player):
            return player
        case .two(let player):
            return player
        }
    }
}
