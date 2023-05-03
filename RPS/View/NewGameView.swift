//
//  NewGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct NewGameView: View {
    @ObservedObject var viewModel: NewGameViewModel

    var body: some View {
        textField
            .navigationDestination(isPresented: $viewModel.isNavigating) {
                if let game = viewModel.game, let player = viewModel.player {
                    GameView(viewModel: GameViewModel(game: game, me: player))
                }
                EmptyView()
            }
    }

    var textField: some View {
        TextFieldBasedView(
            title: "New Game",
            submit: viewModel.submit,
            isLoading: $viewModel.isLoading,
            playerName: $viewModel.myName)
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: NewGameViewModel())
    }
}
