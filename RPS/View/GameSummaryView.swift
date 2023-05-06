//
//  GameSummaryView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

class GameSummaryViewMode: ObservableObject {
    @Published var game: Game
    @Published var isWaiting: Bool
    @Published var waitingMessage: String

    private var me: Player
    private var myNumber: GamePlayerNumber
    private var roundId: String


    init(game: Game, me: Player, myNumber: GamePlayerNumber, roundId: String) {
        self.game = game
        self.me = me
        self.myNumber = myNumber
        self.roundId = roundId
        self.isWaiting = true
        self.waitingMessage = ""
    }

    func checkingGame() {
        GameService.sharedInstance
            .fetchGame(id: game.id) { [weak self] game, error in
                guard let self = self, let game = game else {
                    onError(error)
                    return
                }
                onSuccess(game)

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.checkingGame()
                }
            }

        func onSuccess(_ game: Game) {
            DispatchQueue.main.async {
                self.game = game
                self.isWaiting = !game.isTheRoundFinished(self.roundId)
                self.waitingMessage = getWaitingMessage(game)
            }
        }

        func onError(_ error: Error?) {
            printlog(String(describing: error))
        }

        func getWaitingMessage(_ game: Game) -> String {
            if let opponent = game.getTheOpponent(me) {
                return String.Game.Summary.waitingForAMove(of: opponent.name)
            } else {
                return String.Game.Summary.waitingForOpponent
            }
        }
    }
}

struct GameSummaryView: View {
    @ObservedObject var viewModel: GameSummaryViewMode

    var body: some View {
        VStack {
            if viewModel.isWaiting {
                waitingView
            } else {
                EmptyView()
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
}

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let me = Player(id: "playerId", name: "Carlos")
        let game = Game(id: "gameId", player1: me, player2: nil, finishedRounds: [])
        GameSummaryView(viewModel: GameSummaryViewMode(game: game, me: me, myNumber: .one, roundId: "roundId"))
    }
}
