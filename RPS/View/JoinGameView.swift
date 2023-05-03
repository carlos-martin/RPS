//
//  JoinGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct JoinGameView: View {
    @ObservedObject var viewModel: JoinGameViewModel
    
    var body: some View {
        textField
            .navigationDestination(isPresented: $viewModel.isNavigating) {
                if let game = viewModel.game, let player = viewModel.player {
                    GameView(viewModel: GameViewModel(game: game, me: player))
                }
                EmptyView()
            }
            .alert(isPresented: $viewModel.noGames) {
                Alert(
                    title: Text("Oops"),
                    message: Text("No games available, try again later or create a new game."),
                    dismissButton: .default(Text("OK"))
                )
            }
    }

    var textField: some View {
        TextFieldBasedView(
            title: "Join a Game",
            submit: viewModel.submit,
            isLoading: $viewModel.isLoading,
            playerName: $viewModel.myName)
    }
}

struct JoinGameView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGameView(viewModel: JoinGameViewModel())
    }
}
