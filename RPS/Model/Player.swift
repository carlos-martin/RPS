//
//  Player.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation

struct Player: Codable, JsonConvertable, Equatable {
    let id: String
    let name: String
}
