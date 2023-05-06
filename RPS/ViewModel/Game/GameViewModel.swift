//
//  GameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var onError: Bool
    @Published var playerOne: PlayerInGame
    @Published var playerTwo: PlayerInGame
    @Published var game: Game

    private var myId: String
    private var firstTime: Bool

    init(game: Game, me: Player) {
        self.isLoading = false
        self.onError = false
        self.game = game
        self.playerOne = game.playerOneInGame(myId: me.id)
        self.playerTwo = game.playerTwoInGame(myId: me.id)
        self.myId = me.id
        self.firstTime = true
    }

    func checkingGame() {
        isLoading = true
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    self?.onError(error)
                    return
                }
                onSuccess(game)
            }
    }

    private func onError(_ error: Error?) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.onError = true
            self.isLoading = false
        }
    }

    private func onSuccess(_ game: Game) {
        printlog(game.toJson() ?? "")

        DispatchQueue.main.async {
            self.game = game
            self.playerOne = game.playerOneInGame(myId: self.myId)
            self.playerTwo = game.playerTwoInGame(myId: self.myId)
            self.isLoading = false
        }
    }
}
