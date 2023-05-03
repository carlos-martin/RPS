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

    private func setError(with error: ErrorType) {
        self.isLoading = false
        self.onError = true
        self.errorType = error
    }

    func submit() {
        isLoading = true

        GameService.sharedInstance.fetchAllGames { [weak self] games, error in
            let game = games.first { game in
                game.hasAvailablePlace()
            }
            guard let self = self, let game = game else {
                DispatchQueue.main.async {
                    self?.setError(with: .noGame)
                }
                return
            }
            GameService.sharedInstance.addPlayer(to: game, name: self.myName) { player, error in
                guard let player = player else {
                    DispatchQueue.main.async {
                        self.setError(with: .generic)
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.game = game
                    self.player = player
                    self.isLoading = false
                    self.isNavigating = true
                }

            }
        }
    }
}
