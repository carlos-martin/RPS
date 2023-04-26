//
//  Text+extension.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-26.
//

import SwiftUI

extension Text {
    func dropShadow() -> some View {
        frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2))
    }
}
