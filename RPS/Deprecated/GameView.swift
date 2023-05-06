//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI
import Combine

@available(*, deprecated)
struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        gameView(viewModel.game)
            .navigationTitle(String.Game.activeGame)
            .genericErrorAlert(isPresented: $viewModel.onError)
    }

    func gameView(_ game: Game) -> some View {
        VStack {
            PlayerInGameView(
                viewModel: PlayerInGameViewModel(
                    playerInGame: viewModel.playerOne,
                    game: viewModel.game))

            PlayerInGameView(
                viewModel: PlayerInGameViewModel(
                    playerInGame: viewModel.playerTwo,
                    game: viewModel.game))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        GameView(viewModel: GameViewModel(game: game, me: player))
    }
}
