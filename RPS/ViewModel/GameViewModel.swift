//
//  GameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var game: Game
    var me: Player

    var playerOne: PlayerInGame {
        game.playerOneInGame(myId: me.id)
    }

    var playerTwo: PlayerInGame {
        game.playerTwoInGame(myId: me.id)
    }

    init(game: Game, me: Player) {
        self.isLoading = true
        self.game = game
        self.me = me
    }

    func checkingGame() {
        GameService.sharedInstance.fetchGame(id: game.id) { [weak self] game, error in
            guard let game = game else {
                //TODO: Show error messsage
                self?.isLoading = false
                return
            }
            self?.game = game
            self?.isLoading = false
            printlog(game.toJson() ?? "game not converted to json")
        }
    }
}
