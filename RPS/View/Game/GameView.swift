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

    @State var isLoading: Bool = true

    var body: some View {
        ScrollView {
            loadingView.isHidden($isLoading.not)
            gameView.isHidden($isLoading)
        }
        .navigationTitle("Active Game")
        .onAppear {
            checkingGame()
        }
        .refreshable {
            checkingGame()
        }
    }

    var loadingView: some View {
        ProgressView()
            .padding()
    }

    var gameView: some View {
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

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: viewModel.game.id) { game, error in
                isLoading = false

                guard let game = game else {
                    //TODO: Show error messsage
                    printlog(String(describing: error))
                    return
                }
                printlog(game.toJson() ?? "")

                DispatchQueue.main.async {
                    viewModel.game = game
                }
            }
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
