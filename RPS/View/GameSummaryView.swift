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
        .navigationBarBackButtonHidden(!viewModel.gameOver)
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
            resolutionViewFor(
                name: viewModel.myName,
                move: viewModel.myMove,
                winner: viewModel.amITheWinner,
                victories: viewModel.myVictories)
            resolutionViewFor(
                name: viewModel.opponentName,
                move: viewModel.opponentMove,
                winner: !viewModel.amITheWinner,
                victories: viewModel.opponentVictories)
        }
    }

    func resolutionViewFor(name: String, move: String, winner: Bool, victories: Int) -> some View {
        VStack(alignment: .center) {
            HStack {
                let message = viewModel.isATie ? String.Game.Summary.tie : (winner ? String.Game.Summary.winner : String.Game.Summary.loser)
                Text(message).font(.title)
                Spacer()
            }
            HStack {
                Image.Player.icon
                Text(name).font(.title2)
                Spacer()
            }
            HStack{
                Image.Game.icon
                Text(move).font(.title2)
                Spacer()
            }
            HStack {
                Image.Tropgy.icon
                Text(victories.description).font(.title2)
                Spacer()
            }
        }
        .padding()
    }

}

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let me = Player(id: "playerId", name: "Carlos")
        let game = Game(id: "gameId", player1: me, player2: nil, finishedRounds: [])
        GameSummaryView(viewModel: GameSummaryViewMode(game: game, me: me, myNumber: .one, roundId: "roundId"))
    }
}
