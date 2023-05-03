//
//  View+extension.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Binding<Bool>) -> some View {
        if hidden.wrappedValue {
            self.hidden()
        } else {
            self
        }
    }

    func noGamesAlert(isPresented: Binding<Bool>) -> some View {
        alert(isPresented: isPresented) {
            Alert.noGames
        }
    }

    func genericErrorAlert(isPresented: Binding<Bool>) -> some View {
        alert(isPresented: isPresented) {
            Alert.genericError
        }
    }
}

extension Alert {
    static var genericError: Alert {
        Alert(
            title: Text("Oops"),
            message: Text("Something went wrong, try it again latter."),
            dismissButton: .default(Text("OK"))
        )
    }

    static var noGames: Alert {
        Alert(
            title: Text("Oops"),
            message: Text("No games available, try again later or create a new game."),
            dismissButton: .default(Text("OK"))
        )
    }
}
