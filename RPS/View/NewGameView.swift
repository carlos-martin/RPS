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

    var body: some View {
        VStack {
            TextField("Enter your name", text: $name)
                .padding()
                .border(Color.gray)
                .autocapitalization(.none)
                .disableAutocorrection(true)

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
        .background(
            NavigationLink(
                destination: GameView(),
                isActive: $isNavigating,
                label: {
                    EmptyView()
                })

        )
    }

    func submitName() {
        isShowingActivityIndicator = true

        // Simulate a delay before navigating to the next view
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isShowingActivityIndicator = false
            isNavigating = true
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}
