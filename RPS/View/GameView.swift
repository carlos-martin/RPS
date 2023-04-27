//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct GameView: View {
    @State var game: Game
    var player: Player

    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .padding()
            } else {
                Text("Hello \(player.name), wellcome to game \(game.id)")
            }
        }
        .navigationTitle("Active Game")
        .onAppear {
            checkingGame()
        }
    }

    func checkingGame() {
        GameService.sharedInstance.fetchGame(id: game.id) { game, error in
            isLoading = false
            guard let game = game else {
                //TODO: Show error messsage
                return
            }
            print(game.toJson() ?? "game not converted to json")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "name")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        GameView(game: game, player: player)
    }
}
