//
//  InitialView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                NavigationLink {
                    NewGameView(viewModel: NewGameViewModel())
                } label: {
                    DroppedShadowLabel(title: "New Game")
                }

                NavigationLink {
                    JoinGameView(viewModel: JoinGameViewModel())
                } label: {
                    DroppedShadowLabel(title: "Join a Game")
                }

                Spacer()
            }
        }

    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
