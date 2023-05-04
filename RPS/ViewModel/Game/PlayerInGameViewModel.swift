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
    var playerInGame: PlayerInGame
    var game: Game
    var currentRoundId: String?

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

    @Published var selection: String
    @Published var isDisable: Bool
    @Published var isLoading: Bool
    @Published var doIMoved: Bool

    private var bag: Set<AnyCancellable>

    init(playerInGame: PlayerInGame, game: Game) {
        self.playerInGame = playerInGame
        self.game = game
        self.selection = ""
        self.isDisable = false
        self.isLoading = false
        self.doIMoved = game.playerMovedInCurrentRound(playerInGame.number)
        self.bag = Set<AnyCancellable>()
    }

    deinit {
        bag.removeAll()
    }

    func gameMove() {
        isDisable = true
        isLoading = true
        guard let player = playerInGame.number.player else {
            isDisable = false
            isLoading = false
            return
        }
        let move = Move(player: player, move: MoveOption(description: selection))
        GameService.sharedInstance.gameMove(to: game, move: move) { [weak self] round, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            guard let round = round else {
                printlog(String(describing: error))
                DispatchQueue.main.async {
                    self?.isDisable = false
                }
                return
            }
            self?.currentRoundId = round.id
            self?.game.currentRound = round
            printlog("round: " + (round.toJson() ?? "error encoding to json"))

            DispatchQueue.main.async {
                self?.doIMoved = true
            }
        }
    }
}
