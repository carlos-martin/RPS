//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI
import Combine

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                loadingView
            } else {
                gameView
            }
        }
        .navigationTitle("Active Game")
        .onAppear {
            viewModel.checkingGame()
        }
        .refreshable {
            viewModel.checkingGame()
        }
    }

    var loadingView: some View {
        ProgressView()
    }

    var gameView: some View {
        VStack {
            playerOneView
            playerTwoView
        }
    }

    var playerOneView: some View {
        PlayerInfoView(
            viewModel: PlayerInfoViewModel(
                playerInGame: viewModel.playerOne,
                game: viewModel.game))
    }

    var playerTwoView: some View {
        PlayerInfoView(
            viewModel: PlayerInfoViewModel(
                playerInGame: viewModel.playerTwo,
                game: viewModel.game))
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        let viewModel = GameViewModel(game: game, me: player)
        GameView(viewModel: viewModel)
    }
}
