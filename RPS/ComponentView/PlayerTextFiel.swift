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
            Text(String.TextField.title).font(.title2)
            HStack {
                Image.Player.icon
                TextField(String.TextField.placeholder, text: $name)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
