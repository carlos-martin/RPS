//
//  MoveOption.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

enum MoveOption: String, Codable, JsonConvertable, CustomStringConvertible, CaseIterable, Equatable {
    case rock = "ROCK"
    case paper = "PAPER"
    case scissor = "SCISSOR"
    case none = ""

    init(description: String) {
        var rawValue: String
        switch description {
        case "👊":
            rawValue = "ROCK"
        case "🖐️":
            rawValue = "PAPER"
        case "✌️":
            rawValue = "SCISSOR"
        default:
            rawValue = ""
        }
        self.init(rawValue: rawValue)!
    }

    var description: String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "🖐️"
        case .scissor:
            return "✌️"
        case .none:
            return ""
        }
    }

    static var cases: [String] {
        allCases.map { move in
            move.description
        }
    }
}
