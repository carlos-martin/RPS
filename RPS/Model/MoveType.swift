//
//  MoveType.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

enum MoveType: String, Codable, JsonConvertable, CustomStringConvertible {
    case rock = "ROCK"
    case paper = "PAPER"
    case scissor = "SCISSOR"

    var description: String {
        self.rawValue
    }
}
