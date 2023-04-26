//
//  Move.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

struct Move: Codable, JsonConvertable {
    var playerId: String
    var move: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerId = try container.decode(String.self, forKey: .playerId)
        self.move = try container.decode(String.self, forKey: .move)
    }

    init(player: Player, move: MoveType) {
        self.playerId = player.id
        self.move = move.description
    }
}
