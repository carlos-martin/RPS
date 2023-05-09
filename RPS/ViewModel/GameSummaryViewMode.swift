//
//  GameSummaryViewMode.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-07.
//

import Foundation

class GameSummaryViewMode: ObservableObject {
    @Published var game: Game
    @Published var isWaiting: Bool
    @Published var waitingMessage: String
    @Published var myName: String
    @Published var myMove: String
    @Published var myVictories: Int
    @Published var opponentName: String
    @Published var opponentMove: String
    @Published var opponentVictories: Int
    @Published var amITheWinner: Bool
    @Published var isATie: Bool
    @Published var gameOver: Bool

    private var me: Player
    private var opponent: Player?
    private var myNumber: GamePlayerNumber
    private var roundId: String

    init(game: Game, me: Player, myNumber: GamePlayerNumber, roundId: String) {
        self.game = game
        self.me = me
        self.myNumber = myNumber
        self.roundId = roundId
        self.opponent = nil
        self.isWaiting = true
        self.waitingMessage = ""
        self.myName = me.name
        self.myMove = game.playerMove(me, roundId: roundId)
        self.myVictories = 0
        self.opponentName = ""
        self.opponentMove = ""
        self.opponentVictories = 0
        self.gameOver = false
        self.amITheWinner = false
        self.isATie = true
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    self?.onError(error)
                    return
                }
                self.onSuccess(game)

                if !gameOver {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.checkingGame()
                    }
                }
            }
    }

    private func onSuccess(_ game: Game) {
        DispatchQueue.main.async {
            self.game = game
            self.waitingMessage = self.waitingMessage(game)

            guard game.isTheRoundFinished(self.roundId) else {
                return
            }

            self.isWaiting = false

            guard let opponent = game.getTheOpponentOf(self.me) else {
                return
            }
            self.updateOpponent(opponent, in: game)
            self.updateWiner(in: game, with: opponent)
            self.gameOver = true
        }
    }

    private func onError(_ error: Error?) {
        printlog(String(describing: error))
    }

    private func waitingMessage(_ game: Game) -> String {
        if let opponent = game.getTheOpponentOf(me) {
            return String.Game.Summary.waitingForAMove(of: opponent.name)
        } else {
            return String.Game.Summary.waitingForOpponent
        }
    }

    private func updateOpponent(_ player: Player, in game: Game) {
        opponent = player
        opponentName = player.name
        opponentMove = game.playerMove(player, roundId: self.roundId)
        opponentVictories = game.victories(player)
    }

    private func updateWiner(in game: Game, with opponent: Player) {
        amITheWinner = game.isTheWinner(me, roundId: roundId)
        let opponentIsTheWinner = game.isTheWinner(opponent, roundId: roundId)
        isATie = !amITheWinner && !opponentIsTheWinner
        myVictories = game.victories(me)
    }
}
