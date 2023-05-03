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

    func standarAlert(isPresented: Binding<Bool>) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text("Oops"),
                message: Text("Something went wrong, try it again latter."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
