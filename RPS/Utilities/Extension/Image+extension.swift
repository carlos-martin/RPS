//
//  Image+extension.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import SwiftUI

extension Image {
    struct Player {
        static var icon: Image = Image(systemName: "person")
    }
    struct Game {
        static var icon: Image = Image(systemName: "hand.raised")
    }
    struct DropDown {
        static var icon: Image = Image(systemName: "chevron.up.chevron.down")
    }
}
