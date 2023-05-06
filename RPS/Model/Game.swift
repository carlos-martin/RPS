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

    func getTheOpponent(_ player: Player) -> Player? {
        player1 == player ? player2 : player1
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
            printlog("Player \(player.description) has not moved (there is not active round)")
            return false
        }
        let moved = playerMoveIn(round: activeRoundId, player: player) != nil
        printlog("Player \(player.description) has \(moved ? "" : "not ")moved")
        return moved
    }

    func move(of playerInGame: PlayerInGame, in roundId: String) -> String {
        if playerInGame.isItMe {
            guard let myMove = playerMoveIn(round: roundId, player: playerInGame.number) else {
                return .Game.noMovement
            }
            return myMove.description
        } else {
            guard let _ = playerMoveIn(round: roundId, player: playerInGame.number) else {
                return .Game.noMovement
            }
            return .Game.waitingForYou
        }
    }

    func move(of playerInGame: PlayerInGame) -> String {
        guard let activeRoundId = activeRoundId else {
            return .Game.noMovement
        }
        return move(of: playerInGame, in: activeRoundId)
    }

    func playerName(of playerNumber: PlayerNumber) -> String {
        switch playerNumber {
        case .one:
            return player1?.name ?? .Player.noName
        case .two:
            return player2?.name ?? .Player.noName
        }
    }

    func isPlayerOne(_ playerInGame: PlayerInGame) -> Bool {
        playerInGame.number.player == player1
    }

    func isPlayerTwo(_ playerInGame: PlayerInGame) -> Bool {
        playerInGame.number.player == player2
    }
}

private extension Game {
    var activeRoundId: String? {
        currentRound?.id
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
