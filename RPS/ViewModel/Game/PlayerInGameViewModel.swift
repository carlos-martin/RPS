//
//  PlayerInGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import Combine
import SwiftUI

extension String {
    struct Game {
        static var noMovement: String = "No movement"
        static var waitingForYou: String = "Waiting for you"
    }
}

class PlayerInGameViewModel: ObservableObject {
    @Published var selection: String
    @Published var isDisable: Bool
    @Published var isLoading: Bool
    @Published var doIMoved: Bool

    var currentRoundId: String?
    var playerInGame: PlayerInGame
    var game: Game

    var title: String {
        playerInGame.number.description
    }
    var playerName: String {
        playerInGame.number.name
    }

    var move: String {
        if playerInGame.isItMe {
            guard let activeRoundId = game.activeRoundId,
                  let myMove = game.playerMoveIn(round: activeRoundId, player: playerInGame.number) else {
                return .Game.noMovement
            }
            return myMove.description
        } else {
            guard let activeRoundId = game.activeRoundId,
                  let _ = game.playerMoveIn(round: activeRoundId, player: playerInGame.number) else {
                return .Game.noMovement
            }
            return .Game.waitingForYou
        }
    }

    init(playerInGame: PlayerInGame, game: Game) {
        self.playerInGame = playerInGame
        self.game = game
        self.selection = ""
        self.isDisable = false
        self.isLoading = false
        self.doIMoved = game.playerMovedInCurrentRound(playerInGame.number)
    }

    func gameMove() {
        guard let player = playerInGame.number.player else {
            return
        }

        isDisable = true
        isLoading = true

        let move = Move(player: player, move: MoveOption(description: selection))

        GameService.sharedInstance.gameMove(to: game, move: move) { [weak self] round, error in
            guard let round = round else {
                self?.onError(error)
                return
            }
            self?.onSuccess(round)
        }
    }

    private func onError(_ error: Error?) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.isDisable = false
            self.isLoading = false
        }
    }

    private func onSuccess(_ round: Round) {
        printlog("round: " + (round.toJson() ?? "error encoding to json"))

        currentRoundId = round.id
        game.currentRound = round

        DispatchQueue.main.async {
            self.doIMoved = true
            self.isLoading = false
        }
    }
}
