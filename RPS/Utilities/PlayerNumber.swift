//
//  PlayerNumber.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import Foundation

enum GamePlayerNumber {
    case one
    case two

    var description: String {
        switch self {
        case .one:
            return .Player.one
        case .two:
            return .Player.two
        }
    }
}

@available(*, deprecated)
enum PlayerNumber: Equatable {
    case one(Player?=nil)
    case two(Player?=nil)

    var description: String {
        switch self {
        case .one:
            return .Player.one
        case .two:
            return .Player.two
        }
    }

    var name: String {
        switch self {
        case .one(let player):
            return player?.name ?? .Player.noName
        case .two(let player):
            return player?.name ?? .Player.noName
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
