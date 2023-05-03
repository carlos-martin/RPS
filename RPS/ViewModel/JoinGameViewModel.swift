//
//  JoinGameViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import SwiftUI
import Combine

class JoinGameViewModel: ObservableObject {
    @Published var myName: String
    @Published var isLoading: Bool
    @Published var isNavigating: Bool
    @Published var noGames: Bool
    @Published var game: Game?
    @Published var player: Player?

    private var bag: Set<AnyCancellable>

    init(game: Game? = nil, player: Player? = nil) {
        self.myName = ""
        self.isLoading = false
        self.isNavigating = false
        self.noGames = false
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
                self?.isLoading = false
                self?.noGames = true
                return
            }
            GameService.sharedInstance.addPlayer(to: game, name: self.myName) { player, error in
                guard let player = player else {
                    //TODO: Show error messsage
                    self.isLoading = false
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
