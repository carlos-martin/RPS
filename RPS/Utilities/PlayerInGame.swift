//
//  PlayerInGame.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import Foundation

@available(*, deprecated)
struct PlayerInGame: Equatable, CustomStringConvertible {
    var number: PlayerNumber
    var isItMe: Bool

    var description: String {
        "\(number.description); It is \(isItMe ? "" : "not ")me"
    }
}
