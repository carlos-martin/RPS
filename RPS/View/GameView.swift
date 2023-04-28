//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct GameView: View {
    @State var game: Game

    @State private var player1: PlayerInGame?
    @State private var player2: PlayerInGame?

    var player: Player

    init(game: Game, player: Player) {
        self.game = game
        self.player1 = nil
        self.player2 = nil
        self.player = player
    }

    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .padding()
            } else if let player1 = player1, let player2 = player2 {
                PlayerInAGameView(player1: player1, player2: player2)
            } else {
                Text("WTF!")
            }
        }
        .navigationTitle("Active Game")
        .onAppear {
            checkingGame()
        }
    }

    func checkingGame() {
        GameService.sharedInstance.fetchGame(id: game.id) { game, error in
            guard let game = game else {
                //TODO: Show error messsage
                isLoading = false
                return
            }
            self.game = game

            self.player1 = PlayerInGame(
                player: .player1(game.player1),
                amI: (game.player1?.id ?? "") == player.id,
                moveType: game.currentRound?.player1Move)

            self.player2 = PlayerInGame(
                player: .player2(game.player2),
                amI: (game.player2?.id ?? "") == player.id,
                moveType: game.currentRound?.player2Move)

            isLoading = false
            print(game.toJson() ?? "game not converted to json")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        GameView(game: game, player: player)
    }
}
