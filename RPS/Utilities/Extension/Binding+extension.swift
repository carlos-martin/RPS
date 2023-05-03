//
//  Binding+extension.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-03.
//

import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
