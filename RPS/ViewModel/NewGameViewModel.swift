//
//  NewGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import SwiftUI
import Combine

class NewGameViewModel: ObservableObject {
    @Published var myName: String
    @Published var isLoading: Bool
    @Published var isNavigating: Bool
    @Published var onError: Bool
    @Published var game: Game?
    @Published var player: Player?

    init(game: Game? = nil, player: Player? = nil) {
        self.myName = ""
        self.isLoading = false
        self.isNavigating = false
        self.onError = false
        self.game = game
        self.player = player
    }

    func submit() {
        isLoading = true

        GameService.sharedInstance.createGame { [weak self] game, error in
            guard let self = self, let game = game else {
                self?.onError(error)
                return
            }

            GameService.sharedInstance.addPlayer(to: game, name: self.myName) { player, error in
                guard let player = player else {
                    self.onError(error)
                    return
                }

                GameService.sharedInstance.fetchGame(id: game.id) { updatedGame, error in
                    guard let updatedGame = updatedGame else {
                        self.onError(error)
                        return
                    }
                    self.onSuccess(game: updatedGame, player: player)
                }
            }
        }
    }
    
    private func onError(_ error: Error?) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.onError = true
            self.isLoading = false
        }
    }

    private func onSuccess(game: Game, player: Player) {
        DispatchQueue.main.async {
            self.game = game
            self.player = player
            self.isLoading = false
            self.isNavigating = true
        }
    }
}
