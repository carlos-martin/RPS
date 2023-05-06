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
    @Published var opponentName: String
    @Published var opponentMove: String

    private var me: Player
    private var opponent: Player?
    private var myNumber: GamePlayerNumber
    private var roundId: String
    private var gameOver: Bool

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
        self.opponentName = ""
        self.opponentMove = ""
        self.gameOver = false
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    onError(error)
                    return
                }
                onSuccess(game)

                if !gameOver {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.checkingGame()
                    }
                }
            }

        func onSuccess(_ game: Game) {
            DispatchQueue.main.async {
                self.game = game
                self.waitingMessage = getWaitingMessage(game)
                if game.isTheRoundFinished(self.roundId) {
                    self.isWaiting = false
                    if let opponent = game.getTheOpponentOf(self.me) {
                        self.opponent = opponent
                        self.opponentName = opponent.name
                        self.opponentMove = game.playerMove(opponent, roundId: self.roundId)
                        self.gameOver = true
                    }
                }
            }
        }

        func onError(_ error: Error?) {
            printlog(String(describing: error))
        }

        func getWaitingMessage(_ game: Game) -> String {
            if let opponent = game.getTheOpponentOf(me) {
                return String.Game.Summary.waitingForAMove(of: opponent.name)
            } else {
                return String.Game.Summary.waitingForOpponent
            }
        }
    }
}
