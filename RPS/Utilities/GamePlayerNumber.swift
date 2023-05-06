//
//  GamePlayerNumber.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import Foundation

enum GamePlayerNumber {
    case one
    case two

    var description: String {
        switch self {
        case .one:
            return .Player.one
        case .two:
            return .Player.two
        }
    }
}
