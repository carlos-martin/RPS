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
            number: .one(player1),
            isItMe: (player1?.id ?? "") == myId)
    }

    func playerTwoInGame(myId: String) -> PlayerInGame {
        PlayerInGame(
            number: .two(player2),
            isItMe: (player2?.id ?? "") == myId)
    }

    var activeRoundId: String? {
        currentRound?.id
    }

    func isWaitingFor(player: PlayerNumber) -> Bool {
        guard let activeRoundId = activeRoundId else {
            return false
        }
        switch player {
        case .one:
            return hasPlayerMovedIn(round: activeRoundId, player: .two())
        case .two:
            return hasPlayerMovedIn(round: activeRoundId, player: .one())
        }
    }

    func playerMovedInCurrentRound(_ player: PlayerNumber) -> Bool {
        guard let activeRoundId = activeRoundId else {
            return false
        }
        return playerMoveIn(round: activeRoundId, player: player) != nil
    }

    func playerMoveIn(round id: String, player: PlayerNumber) -> MoveOption? {
        guard let round = fetchRoundBy(id: id) else {
            return nil
        }
        switch player {
        case .one:
            return round.player1Move
        case .two:
            return round.player2Move
        }
    }
}

private extension Game {
    func hasPlayerMovedIn(round id: String, player: PlayerNumber) -> Bool {
        playerMoveIn(round: id, player: player) != nil
    }

    func fetchRoundBy(id: String) -> Round? {
        if isThisTheCurrentRound(round: id) {
            return currentRound
        } else {
            return fetchFinishedRoundBy(id: id)
        }
    }

    func isThisTheCurrentRound(round id: String) -> Bool {
        guard let currentRound = currentRound else {
            return false
        }
        return currentRound.id == id
    }

    func fetchFinishedRoundBy(id: String) -> Round? {
        finishedRounds.first { round in
            round.id == id
        }
    }
}
