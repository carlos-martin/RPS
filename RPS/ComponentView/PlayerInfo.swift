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
        playerInGame.number.description
    }
    var playerName: String {
        playerInGame.number.name
    }
    var move: String {
        playerInGame.currentMove?.description ?? "No movement"
    }

    @State var selection: String = ""
    @State var isDisable: Bool = false
    @State var isLoading: Bool = false
    @State var text: String = ""
    
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
            if playerInGame.isItMe {
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
            if playerInGame.isItMe {
                let text = selection.description.isEmpty ? "No movement" : selection.description
                Text(text).font(.title)
                DropDownView(selection: $selection)
                submitButtonView
            } else {
                Text(move).font(.title)
            }
            if isLoading {
                ProgressView()
                    .padding()
            }
        }
    }

    var submitButtonView: some View {
        SubmitButton(disable: $isDisable, action: gameMove)
    }

    func gameMove() {
        isDisable = true
        isLoading = true
        guard let player = playerInGame.number.player else {
            isDisable = false
            isLoading = false
            return
        }
        let move = Move(player: player, move: MoveOption(description: selection))
        GameService.sharedInstance.gameMove(to: game, move: move) { round, error in
            isLoading = false
            guard let round = round else {
                printlog(String(describing: error))
                isDisable = false
                return
            }
            printlog(round.toJson() ?? "error encoding to json")
        }
    }
}

struct PlayerInfo_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        let number: PlayerNumber = .one(player)
        PlayerInfo(
            playerInGame: PlayerInGame(number: number, isItMe: true),
            game: game)
    }
}
