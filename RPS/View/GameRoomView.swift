//
//  GameRoom.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

struct GameRoomView: View {
    @ObservedObject var viewModel: GameRoomViewModel

    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                titleView
                infoView
                moveView
            }
            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.doIMoved) {
            GameSummaryView()
        }

    }

    var titleView: some View {
        Text(viewModel.myNumber).font(.title2)
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

struct GameRoomView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
