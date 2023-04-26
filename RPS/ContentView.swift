//
//  ContentView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let service = GameService()

            service.createGame { game, _ in
                print(game ?? "nil")
            }

            service.fetchAllGames { games, _ in
                print(games.description)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
