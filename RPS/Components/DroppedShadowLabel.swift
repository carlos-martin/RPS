//
//  DroppedShadowLabel.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

struct DroppedShadowLabel: View {
    var title: String

    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .dropShadow()
        .padding()
    }
}

struct DroppedShadowLabel_Previews: PreviewProvider {
    static var previews: some View {
        DroppedShadowLabel(title: "Hello world!")
    }
}
