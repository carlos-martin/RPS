//
//  Game.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

struct Game: Codable, JsonConvertable, Equatable {
    let id: String
    let player1: Player?
    let player2: Player?
    var currentRound: Round?
    var finishedRounds: [Round]

    func hasAvailablePlace() -> Bool {
        player1 == nil || player2 == nil
    }

    func playerNumber(_ player: Player) -> GamePlayerNumber {
        player1 == player ? .one : .two
    }

    func isTheRoundFinished(_ roundId: String) -> Bool {
        guard currentRound?.id != roundId else {
            return false
        }
        let round = finishedRounds.first { round in
            round.id == roundId
        }
        return round != nil
    }

    func getTheOpponentOf(_ player: Player) -> Player? {
        player1 == player ? player2 : player1
    }

    func playerMove(_ player: Player, roundId: String) -> String {
        let playerNumber = playerNumber(player)
        guard let round = fetchRoundBy(id: roundId) else {
            return ""
        }

        switch playerNumber {
        case .one:
            return round.player1Move?.description ?? ""
        case .two:
            return round.player2Move?.description ?? ""
        }
    }

    func isTheWinner(_ player: Player, roundId: String) -> Bool {
        guard let round = fetchRoundBy(id: roundId),
              let winner = round.winner() else {
            return false
        }
        switch winner {
        case .one:
            return player == player1
        case .two:
            return player == player2
        }
    }
}

private extension Game {
    var activeRoundId: String? {
        currentRound?.id
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
