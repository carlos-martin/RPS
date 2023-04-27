//
//  PlayerTextFiel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-27.
//

import SwiftUI

struct PlayerTextFiel: View {
    @Binding var name: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Player name").font(.title2)
            HStack {
                Image(systemName: "person")
                TextField("Enter your name", text: $name)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
