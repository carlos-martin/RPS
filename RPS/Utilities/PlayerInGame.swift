//
//  PlayerInGame.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import Foundation

struct PlayerInGame {
    var number: PlayerNumber
    var isItMe: Bool
    var currentMove: MoveOption?
    var hasMoved: Bool {
        currentMove != nil
    }
}
