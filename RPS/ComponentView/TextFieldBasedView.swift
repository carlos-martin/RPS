//
//  TextFieldBasedView.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-27.
//

import SwiftUI

struct TextFieldBasedView: View {
    var title: String
    var submit: (()->Void)
    @Binding var isLoading: Bool
    @Binding var playerName: String

    var body: some View {
        VStack {
            PlayerTextFiel(name: $playerName)

            Button(action: submit) {
                Text(String.Button.submit)
            }
            .padding()
            .disabled(playerName.isEmpty || isLoading)

            if isLoading {
                ProgressView()
                    .padding()
            }
        }
        .navigationTitle(title)
    }
}
