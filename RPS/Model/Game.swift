//
//  Game.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

struct Game: Codable, JsonConvertable {
    let id: String
    let player1: Player?
    let player2: Player?
    var currentRound: Round?
    var finishedRounds: [Round]
}
