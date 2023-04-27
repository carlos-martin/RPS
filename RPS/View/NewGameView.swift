//
//  NewGameView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct NewGameView: View {
    @State private var name = ""
    @State private var isShowingActivityIndicator = false
    @State private var isNavigating = false

    @State private var game: Game?
    @State private var player: Player?

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Player name").font(.title2)
                HStack {
                    Image(systemName: "person")
                    TextField("Enter your name", text: $name)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            Button(action: submitName) {
                Text("Submit")
            }
            .padding()
            .disabled(name.isEmpty || isShowingActivityIndicator)

            if isShowingActivityIndicator {
                ProgressView()
                    .padding()
            }
        }
        .navigationTitle("New Game")
        .navigationDestination(
            isPresented: $isNavigating) {
                if let game = game, let player = player {
                    GameView(game: game, player: player)
                    EmptyView()
                }
                EmptyView()
            }
    }

    func submitName() {
        isShowingActivityIndicator = true

        GameService.sharedInstance.createGame { game, error in
            guard let game = game else {
                //TODO: Show error messsage
                isShowingActivityIndicator = false
                return
            }
            self.game = game
            GameService.sharedInstance.addPlayer(to: game, name: name) { player, error in
                guard let player = player else {
                    //TODO: Show error messsage
                    isShowingActivityIndicator = false
                    return
                }

                self.player = player
                isShowingActivityIndicator = false
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
