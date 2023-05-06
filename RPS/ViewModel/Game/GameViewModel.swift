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
    private var firstTime: Bool

    init(game: Game, me: Player) {
        self.onError = false
        self.game = game
        self.playerOne = game.playerOneInGame(myId: me.id)
        self.playerTwo = game.playerTwoInGame(myId: me.id)
        self.myId = me.id
        self.firstTime = true
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    self?.onError(error)
                    return
                }
                onSuccess(game)

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.checkingGame()
                }
            }
    }

    private func onError(_ error: Error?) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.onError = true
        }
    }

    private func onSuccess(_ game: Game) {
        DispatchQueue.main.async {
            if self.game != game {
                self.game = game
                self.playerOne = game.playerOneInGame(myId: self.myId)
                self.playerTwo = game.playerTwoInGame(myId: self.myId)
                printlog(game.toJson() ?? "")
            }
        }
    }
}