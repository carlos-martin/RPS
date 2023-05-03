//
//  PlayerInGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-28.
//

import SwiftUI

struct PlayerInGameView: View {
    @ObservedObject var viewModel: PlayerInGameViewModel

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
            Text(viewModel.title).font(.title2)
            if viewModel.playerInGame.isItMe {
                Text("(you)").font(.footnote)
            }
        }
    }

    var playerSummaryView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "person")
            Text(viewModel.playerName).font(.title)
        }
    }

    var moveSummaryView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "hand.raised")
            if viewModel.playerInGame.isItMe {
                let text = viewModel.selection.isEmpty ? "No movement" : viewModel.selection.description
                Text(text).font(.title)
                DropDownView(selection: $viewModel.selection)
                submitButtonView
            } else {
                Text(viewModel.move).font(.title)
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }

    var submitButtonView: some View {
        SubmitButton(disable: $viewModel.isDisable, action: viewModel.gameMove)
    }
}

struct PlayerInfo_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        let player = Player(id: "id", name: "Carlos")
        let game = Game(id: "id", player1: player, player2: nil, finishedRounds: [])
        let number: PlayerNumber = .one(player)
        let playerInGame = PlayerInGame(number: number, isItMe: true)
        let viewModel = PlayerInGameViewModel(playerInGame: playerInGame, game: game)
        PlayerInGameView(viewModel: viewModel)
    }
}
