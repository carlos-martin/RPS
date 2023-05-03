//
//  PlayerInAGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct PlayerInAGameView: View {
    var player1: PlayerInGame
    var player2: PlayerInGame
    var game: Game

    var body: some View {
        VStack {
            PlayerInfo(playerInGame: player1, game: game)
            PlayerInfo(playerInGame: player2, game: game)
        }
    }
}

struct PlayerInAGameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        PlayerInAGameView(
            player1: PlayerInGame(number: .one(player), isItMe: true, currentMove: .paper),
            player2: PlayerInGame(number: .two(nil), isItMe: false),
            game: game
        )
    }
}
