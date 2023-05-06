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
                if let game = viewModel.game, let me = viewModel.player {
                    GameRoomView(viewModel: GameRoomViewModel(me: me, game: game))
                }
                EmptyView()
            }
            .genericErrorAlert(isPresented: $viewModel.onError)
    }

    var textField: some View {
        TextFieldBasedView(
            title: String.Onboard.newGame,
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
