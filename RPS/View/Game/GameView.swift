//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI
import Combine

struct GameView: View {
    @State private var isLoading: Bool = true
    @State private var onError: Bool = false

    @State var game: Game
    var me: Player

    var body: some View {
        ScrollView {
            if isLoading {
                loadingView
            } else {
                gameView
            }
        }
        .navigationTitle("Active Game")
        .onAppear {
            checkingGame()
        }
        .refreshable {
            checkingGame()
        }
        .genericErrorAlert(isPresented: $onError)
    }

    var loadingView: some View {
        ProgressView()
            .padding()
    }

    var gameView: some View {
        VStack {
            PlayerInGameView(
                viewModel: PlayerInGameViewModel(
                    playerInGame: game.playerOneInGame(myId: me.id),
                    game: game))

            PlayerInGameView(
                viewModel: PlayerInGameViewModel(
                    playerInGame: game.playerTwoInGame(myId: me.id),
                    game: game))
        }
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { game, error in
                guard let game = game else {
                    printlog(String(describing: error))
                    DispatchQueue.main.async {
                        self.onError = true
                        self.isLoading = false
                    }
                    return
                }
                printlog(game.toJson() ?? "")

                DispatchQueue.main.async {
                    self.game = game
                    self.isLoading = false
                }

            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        GameView(game: game, me: player)
    }
}
