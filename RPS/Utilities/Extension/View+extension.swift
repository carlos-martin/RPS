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

    func quiteGameAlert(isPresented: Binding<Bool>, action: (() -> Void)?) -> some View {
        alert(isPresented: isPresented) {
            Alert.quiteGame(action: action)
        }
    }
}

extension Alert {
    static var genericError: Alert {
        Alert(
            title: Text(String.Alert.Generic.title),
            message: Text(String.Alert.Generic.message),
            dismissButton: .default(Text(String.Alert.Generic.button)))
    }

    static var noGames: Alert {
        Alert(
            title: Text(String.Alert.NoGames.title),
            message: Text(String.Alert.NoGames.message),
            dismissButton: .default(Text(String.Alert.NoGames.button)))
    }

    static func quiteGame(action: (() -> Void)?) -> Alert {
        Alert(
            title: Text(String.Alert.Dismiss.title),
            message: Text(String.Alert.Dismiss.message),
            primaryButton: .destructive(Text(String.Alert.Dismiss.button), action: action),
            secondaryButton: .cancel())
    }
}
