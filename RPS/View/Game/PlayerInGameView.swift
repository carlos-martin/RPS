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
                playerTitleView
                playerInfoView
                playerMoveView
            }
            Spacer()
        }
        .padding()
        .onAppear {
            guard !viewModel.playerInGame.isItMe else { return }
            viewModel.checkingGame()
        }
    }

    var playerTitleView: some View {
        HStack {
            Text(viewModel.playerNumber).font(.title2)
            if viewModel.playerInGame.isItMe {
                Text("(you)").font(.footnote)
            }
        }
    }

    var playerInfoView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "person")
            Text(viewModel.playerName).font(.title)
        }
    }

    var playerMoveView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "hand.raised")
            if viewModel.playerInGame.isItMe && !viewModel.doIMoved {
                let text = viewModel.selection.isEmpty ? .Game.noMovement : viewModel.selection.description
                Text(text).font(.title)
                DropDownView(selection: $viewModel.selection)
                submitButtonView
            } else {
                Text(viewModel.playerMove).font(.title)
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
