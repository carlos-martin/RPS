//
//  GameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var onError: Bool
    @Published var playerOne: PlayerInGame
    @Published var playerTwo: PlayerInGame
    @Published var game: Game

    private var myId: String

    init(game: Game, me: Player) {
        self.onError = false
        self.game = game
        self.playerOne = game.playerOneInGame(myId: me.id)
        self.playerTwo = game.playerTwoInGame(myId: me.id)
        self.myId = me.id
    }
}
