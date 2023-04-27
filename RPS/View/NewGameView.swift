//
//  NewGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct NewGameView: View {
    @State private var name = ""
    @State private var isLoading = false
    @State private var isNavigating = false
    @State private var game: Game?
    @State private var player: Player?

    var body: some View {
        TextFieldBasedView(title: "New Game", submit: submit, isLoading: $isLoading, playerName: $name)
            .navigationDestination(isPresented: $isNavigating) {
                if let game = game, let player = player {
                    GameView(game: game, player: player)
                    EmptyView()
                }
                EmptyView()
        }
    }

    func submit() {
        isLoading = true

        GameService.sharedInstance.createGame { game, error in
            guard let game = game else {
                //TODO: Show error messsage
                isLoading = false
                return
            }
            self.game = game
            GameService.sharedInstance.addPlayer(to: game, name: name) { player, error in
                guard let player = player else {
                    //TODO: Show error messsage
                    isLoading = false
                    return
                }

                self.player = player
                isLoading = false
                isNavigating = true
            }
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}
