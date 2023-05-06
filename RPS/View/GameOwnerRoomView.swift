//
//  GameRoom.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

struct GameOwnerRoomView: View {
    @ObservedObject var viewModel: GameOwnerRoomViewModel

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
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.doIMoved) {
            GameSummaryView(viewModel: GameSummaryViewMode(
                game: viewModel.game,
                me: viewModel.me,
                myNumber: viewModel.myNumber,
                roundId: viewModel.roundId))
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
        SubmitButton(disable: $viewModel.submitIsDisable, action: viewModel.sendMyMove)
    }
}

