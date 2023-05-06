//
//  JoinGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import SwiftUI
import Combine

class JoinGameViewModel: ObservableObject {
    enum ErrorType {
        case noGame
        case generic
        case none
    }

    @Published var myName: String
    @Published var isLoading: Bool
    @Published var isNavigating: Bool
    @Published var onError: Bool
    @Published var errorType: ErrorType
    @Published var game: Game?
    @Published var player: Player?

    private var bag: Set<AnyCancellable>

    init(game: Game? = nil, player: Player? = nil) {
        self.myName = ""
        self.isLoading = false
        self.isNavigating = false
        self.onError = false
        self.errorType = .none
        self.game = game
        self.player = player
        self.bag = Set<AnyCancellable>()
    }

    deinit {
        bag.removeAll()
    }

    func submit() {
        isLoading = true

        GameService.sharedInstance.fetchAllGames { [weak self] games, error in
            let game = games.first { game in
                game.hasAvailablePlace()
            }

            guard let self = self, let game = game else {
                self?.onError(error, of: .noGame)
                return
            }

            GameService.sharedInstance.addPlayer(to: game, name: self.myName) { player, error in
                guard let player = player else {
                    self.onError(error, of: .generic)
                    return
                }

                GameService.sharedInstance.fetchGame(id: game.id) { updatedGame, error in
                    guard let updatedGame = updatedGame else {
                        self.onError(error, of: .generic)
                        return
                    }
                    self.onSuccess(game: updatedGame, player: player)
                }
            }
        }
    }

    private func onError(_ error: Error?, of type: ErrorType) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.isLoading = false
            self.onError = true
            self.errorType = type
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
