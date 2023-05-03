//
//  PlayerInGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import Combine
import SwiftUI

class PlayerInGameViewModel: ObservableObject {
    var playerInGame: PlayerInGame
    var game: Game

    var title: String {
        playerInGame.number.description
    }
    var playerName: String {
        playerInGame.number.name
    }
    var move: String {
        playerInGame.currentMove?.description ?? "No movement"
    }

    @Published var selection: String
    @Published var isDisable: Bool
    @Published var isLoading: Bool

    private var bag: Set<AnyCancellable>

    init(playerInGame: PlayerInGame, game: Game) {
        self.playerInGame = playerInGame
        self.game = game
        self.selection = ""
        self.isDisable = false
        self.isLoading = false
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
                self?.isDisable = false
                return
            }
            printlog(round.toJson() ?? "error encoding to json")
        }
    }
}
