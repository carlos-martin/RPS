//
//  PlayerInfo.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct PlayerInfo: View {
    var player: PlayerInGame

    var title: String {
        player.player.title
    }
    var playerName: String {
        player.player.name
    }
    var move: String {
        player.moveType?.description ?? "No movement"
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack {
                    Text(title).font(.title2)
                    if player.amI {
                        Text("(you)").font(.footnote)
                    }
                }
                HStack(alignment: .center) {
                    Image(systemName: "person")
                    Text(playerName).font(.title)
                }
                HStack(alignment: .center) {
                    Image(systemName: "hand.raised")
                    Text(move).font(.title)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
        }
        .padding()
    }
}

struct PlayerInfo_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: "id", name: "Carlos")
        let playerType: PlayerType = .player1(player)
        PlayerInfo(player: PlayerInGame(player: playerType, amI: true, moveType: .paper))
    }
}
