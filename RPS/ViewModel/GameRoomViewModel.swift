//
//  GameRoomViewModel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import Foundation

class GameRoomViewModel: ObservableObject {
    @Published var myNumberLabel: String
    @Published var myName: String
    @Published var mySelection: String
    @Published var doIMoved: Bool
    @Published var isLoading: Bool
    @Published var roundId: String

    var me: Player
    var myNumber: GamePlayerNumber
    var game: Game

    init(me: Player, game: Game) {
        self.me = me
        self.game = game
        self.myNumber = game.playerNumber(me)
        self.myNumberLabel = myNumber.description
        self.myName = me.name
        self.mySelection = ""
        self.doIMoved = false
        self.isLoading = false
        self.roundId = ""
    }

    func sendMyMove() {
        isLoading = true

        let move = Move(player: me, move: MoveOption(description: mySelection))
        GameService.sharedInstance.gameMove(to: game, move: move) { [weak self] round, error in
            guard let round = round else {
                self?.onError(error)
                return
            }
            self?.onSuccess(move, in: round)
        }
    }

    private func onError(_ error: Error?) {
        printlog(String(describing: error))
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }

    private func onSuccess(_ move: Move, in round: Round) {
        DispatchQueue.main.async {
            self.roundId = round.id
            self.game.currentRound = round
            self.isLoading = false
            self.doIMoved = true
        }
    }
}
