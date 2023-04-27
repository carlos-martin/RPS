//
//  JoinGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct JoinGameView: View {
    @State private var name = ""
    @State private var isLoading = false
    @State private var isNavigating = false
    @State private var noGames = false
    @State private var game: Game?
    @State private var player: Player?
    
    var body: some View {
        TextFieldBasedView(title: "Join a Game", submit: submit, isLoading: $isLoading, playerName: $name)
            .navigationDestination(isPresented: $isNavigating) {
                if let game = game, let player = player {
                    GameView(game: game, player: player)
                    EmptyView()
                }
                EmptyView()
            }
            .alert(isPresented: $noGames) {
                Alert(
                    title: Text("Oops"),
                    message: Text("No games available, try again later or create a new game."),
                    dismissButton: .default(Text("OK"))
                )
            }
    }

    func submit() {
        isLoading = true
        
        GameService.sharedInstance.fetchAllGames { games, error in
            let game = games.first { game in
                game.hasAvailablePlace()
            }
            guard let game = game else {
                isLoading = false
                noGames = true
                return
            }
            GameService.sharedInstance.addPlayer(to: game, name: name) { player, error in
                guard let player = player else {
                    //TODO: Show error messsage
                    isLoading = false
                    return
                }

                self.player = player
                self.game = game

                isLoading = false
                isNavigating = true
            }
        }
    }
}

struct JoinGameView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGameView()
    }
}
