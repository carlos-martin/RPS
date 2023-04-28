//
//  SubmitButton.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-27.
//

import SwiftUI

struct SubmitButton: View {
    @Binding var disable: Bool

    var action: (() -> Void)

    var body: some View {
        Button(action: action) {
            Text("Submit")
        }
        .disabled(disable)
    }
}
