//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct GameView: View {

    @State private var isLoading = true
    @State var game: Game
    var player: Player

    init(game: Game, player: Player) {
        self.game = game
        self.player = player
    }

    var body: some View {
        ScrollView {
            VStack {
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    PlayerInAGameView(
                        player1: game.playerOneInGame(myId: player.id),
                        player2: game.playerTwoInGame(myId: player.id))
                }
            }
        }
        .navigationTitle("Active Game")
        .onAppear {
            checkingGame()
        }
        .refreshable {
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
