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

    var body: some View {
        VStack {
            PlayerInfo(player: player1)
            PlayerInfo(player: player2)
        }
    }
}

struct PlayerInAGameView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        PlayerInAGameView(
            player1: PlayerInGame(player: .player1(player), amI: true, moveType: .paper),
            player2: PlayerInGame(player: .player2(nil), amI: false, moveType: nil)
        )
    }
}
