//
//  GameRoomView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

struct GameRoomView: View {
    @ObservedObject var viewModel: GameRoomViewModel
    @State private var quitGame: Bool = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                titleView
                infoView
                moveView
            }
            Spacer()
        }
        .padding()
        .navigationTitle(String.Game.activeGame)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.doIMoved) {
            GameSummaryView(viewModel: GameSummaryViewMode(
                game: viewModel.game,
                me: viewModel.me,
                myNumber: viewModel.myNumber,
                roundId: viewModel.roundId))
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    quitGame = true
                }, label: {
                    Image.Close.icon
                })
        )
        .alert(isPresented: $quitGame) {
            Alert.quiteGame {
                NavigationUtil.popToRootView()
            }
        }

    }

    var titleView: some View {
        Text(viewModel.myNumberLabel).font(.title2)
    }

    var infoView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image.Player.icon
            Text(viewModel.myName).font(.title)
        }
    }

    var moveView: some View {
        HStack(alignment: .center, spacing: 8) {
            Image.Game.icon
            mySelectedMoveView
            dropDownView
            submitButtonView

            if viewModel.isLoading {
                ProgressView()
            }
        }
    }

    var mySelectedMoveView: some View {
        let move = viewModel.mySelection.isEmpty ? .Game.noMovement : viewModel.mySelection
        return Text(move).font(.title)
    }

    var dropDownView: some View {
        DropDownView(selection: $viewModel.mySelection)
    }

    var submitButtonView: some View {
        SubmitButton(disable: .constant(false), action: viewModel.sendMyMove)
    }
}

