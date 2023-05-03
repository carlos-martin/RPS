//
//  GameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var game: Game
    var me: Player

    var playerOne: PlayerInGame {
        game.playerOneInGame(myId: me.id)
    }

    var playerTwo: PlayerInGame {
        game.playerTwoInGame(myId: me.id)
    }

    init(game: Game, me: Player) {
        self.game = game
        self.me = me
    }

}
