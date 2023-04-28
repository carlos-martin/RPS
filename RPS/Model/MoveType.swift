//
//  MoveType.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

enum MoveType: String, Codable, JsonConvertable, CustomStringConvertible, CaseIterable {
    case rock = "ROCK"
    case paper = "PAPER"
    case scissor = "SCISSOR"

    var description: String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "🖐️"
        case .scissor:
            return "✌️"
        }
    }

    static var cases: [String] {
        var result = [""]
        result.append(contentsOf:allCases.map { move in
            move.description
        })
        return result
    }
}
