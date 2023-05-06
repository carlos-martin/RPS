//
//  PlayerInGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import Combine
import SwiftUI

class PlayerInGameViewModel: ObservableObject {
    @Published var selection: String
    @Published var isDisable: Bool
    @Published var isLoading: Bool
    @Published var doIMoved: Bool
    @Published var playerNumber: String
    @Published var playerName: String
    @Published var playerMove: String

    private var currentRoundId: String?
    private var game: Game

    var playerInGame: PlayerInGame

    init(playerInGame: PlayerInGame, game: Game) {
        self.playerInGame = playerInGame
        self.game = game
        self.selection = ""
        self.isDisable = false
        self.isLoading = false
        self.doIMoved = game.playerMovedInCurrentRound(playerInGame.number)
        self.playerMove = game.move(of: playerInGame)
        self.playerName = playerInGame.number.name
        self.playerNumber = playerInGame.number.description
    }

    func gameMove() {
        guard let player = playerInGame.number.player else {
            return
        }

        isDisable = true
        isLoading = true

        let move = Move(player: player, move: MoveOption(description: selection))

        GameService.sharedInstance.gameMove(to: game, move: move) { round, error in
            guard let round = round else {
                onError(error)
                return
            }
            onSuccess(move, in: round)
        }

        func onSuccess(_ move: Move, in round: Round) {
            printlog("round: " + (round.toJson() ?? "error encoding to json"))

            currentRoundId = round.id
            game.currentRound = round


            DispatchQueue.main.async {
                self.doIMoved = true
                self.isLoading = false
                self.playerMove = self.selection.description
            }
        }

        func onError(_ error: Error?) {
            printlog(String(describing: error))
            DispatchQueue.main.async {
                self.isDisable = false
                self.isLoading = false
            }
        }
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    onError(error)
                    return
                }
                onSuccess(game)

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.checkingGame()
                }
            }

        func onSuccess(_ game: Game) {
            guard self.game != game else {
                return
            }
            self.game = game
            updatePlayerName(playerInGame, in: game)
            updatePlayerMove(playerInGame, in: game)
        }

        func onError(_ error: Error?) {
            printlog(String(describing: error))
        }
    }

    private func updatePlayerName(_ playerInGame: PlayerInGame, in game: Game) {
        DispatchQueue.main.async {
            self.playerName = game.playerName(of: playerInGame.number)
            printlog(playerInGame.description + "; Name: " + self.playerName)
        }
    }

    private func updatePlayerMove(_ playerInGame: PlayerInGame, in: Game, at roundId: String?=nil) {
        var move: String
        if let roundId = roundId {
            move = game.move(of: playerInGame, in: roundId)
        } else {
            move = game.move(of: playerInGame)
        }
        DispatchQueue.main.async {
            self.playerMove = move
            printlog(self.playerMove)
        }
    }
}
