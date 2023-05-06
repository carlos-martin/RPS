//
//  GameSummaryView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

struct GameSummaryView: View {
    @ObservedObject var viewModel: GameSummaryViewMode

    var body: some View {
        VStack {
            if viewModel.isWaiting {
                waitingView
            } else {
                resolutionView
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.checkingGame()
        }
    }

    var waitingView: some View {
        VStack {
            Text(viewModel.waitingMessage).font(.headline)
            ProgressView()
                .padding()
        }
    }

    var resolutionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.myName).font(.title)
                Text(viewModel.myMove).font(.title)
            }
            HStack {
                Text(viewModel.opponentName).font(.title)
                Text(viewModel.opponentMove).font(.title)
            }
        }
    }

}

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let me = Player(id: "playerId", name: "Carlos")
        let game = Game(id: "gameId", player1: me, player2: nil, finishedRounds: [])
        GameSummaryView(viewModel: GameSummaryViewMode(game: game, me: me, myNumber: .one, roundId: "roundId"))
    }
}
