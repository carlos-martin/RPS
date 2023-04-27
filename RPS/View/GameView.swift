//
//  GameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct GameView: View {
    var game: Game
    var player: Player

    var body: some View {
        VStack {
            Text("Hello \(player.name), wellcome to game \(game.id)")
        }
        .navigationTitle("Active Game")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "name")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        GameView(
            game: game,
            player: player)
    }
}
