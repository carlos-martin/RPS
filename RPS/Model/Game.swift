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

    func hasAvailablePlace() -> Bool {
        player1 == nil || player2 == nil
    }

    func playerOneInGame(myId: String) -> PlayerInGame {
        PlayerInGame(
            playerType: .player1(player1),
            amI: (player1?.id ?? "") == myId,
            moveType: currentRound?.player1Move)
    }

    func playerTwoInGame(myId: String) -> PlayerInGame {
        PlayerInGame(
            playerType: .player2(player2),
            amI: (player2?.id ?? "") == myId,
            moveType: currentRound?.player2Move)
    }
}
