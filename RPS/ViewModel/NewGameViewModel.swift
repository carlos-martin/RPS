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
    @Published var game: Game?
    @Published var player: Player?

    private var bag: Set<AnyCancellable>

    init(game: Game? = nil, player: Player? = nil) {
        self.myName = ""
        self.isLoading = false
        self.isNavigating = false
        self.game = game
        self.player = player
        self.bag = Set<AnyCancellable>()
    }

    deinit {
        bag.removeAll()
    }

    func submit() {
        isLoading = true

        GameService.sharedInstance.createGame { [weak self] game, error in
            guard let self = self, let game = game else {
                //TODO: Show error messsage
                printlog(String(describing: error))
                self?.isLoading = false
                return
            }

            GameService.sharedInstance.addPlayer(to: game, name: self.myName) { player, error in
                guard let player = player else {
                    //TODO: Show error messsage
                    printlog(String(describing: error))
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
