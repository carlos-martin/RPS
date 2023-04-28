//
//  PlayerInfo.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct PlayerInfo: View {
    var playerInGame: PlayerInGame
    var game: Game

    var title: String {
        playerInGame.playerType.title
    }
    var playerName: String {
        playerInGame.playerType.name
    }
    var move: String {
        playerInGame.moveType?.description ?? "No movement"
    }

    @State var selection: String = ""
    @State var isDisable: Bool = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                headerView
                playerSummaryView
                moveSummaryView
            }
            Spacer()
        }
        .padding()
    }

    var headerView: some View {
        HStack {
            Text(title).font(.title2)
            if playerInGame.amI {
                Text("(you)").font(.footnote)
            }
        }
    }

    var playerSummaryView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "person")
            Text(playerName).font(.title)
        }
    }

    var moveSummaryView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "hand.raised")
            if playerInGame.amI {
                let text = selection.isEmpty ? "No movement" : selection
                Text(text).font(.title)
                DropDownView(selection: $selection)
                submitButtonView
            } else {
                Text(move).font(.title)
            }
        }
    }

    var submitButtonView: some View {
        SubmitButton(disable: $isDisable, action: gameMove)
    }

    func gameMove() {
        isDisable = true
        guard let moveType = MoveType(rawValue: selection),
              let player = playerInGame.playerType.player else {
            return
        }
        let move = Move(player: player, move: moveType)
        GameService.sharedInstance.gameMove(to: game, move: move) { round, error in
            guard let round = round else {
                print(String(describing: error))
                isDisable = false
                return
            }
            print(round.toJson() ?? "error encoding to json")
        }
    }
}

struct PlayerInfo_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        let playerType: PlayerType = .player1(player)
        PlayerInfo(
            playerInGame: PlayerInGame(playerType: playerType, amI: true, moveType: nil),
            game: game)
    }
}
