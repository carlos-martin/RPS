//
//  MoveTests.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest
@testable import RPS

class MoveTests: XCTestCase {
    func testMoveFromJSON() throws {
        let jsonString = loadJsonStringFromFile("move_valid")
        guard let move = Move.fromSingleJson(jsonString) else {
            XCTFail()
            return
        }
        XCTAssertEqual(move.playerId, "6ef3a61c-c65f-42cc-9673-88c15fdfcb11")
        XCTAssertEqual(move.move, "ROCK")
    }

    func testMoveFromInvalidJSON() throws {
        let jsonString = loadJsonStringFromFile("move_invalid")
        let move = Move.fromSingleJson(jsonString)

        XCTAssertNil(move)
    }

    func testMoveFromPlayerAndMoveOption() {
        let player = Player(id: "6ef3a61c-c65f-42cc-9673-88c15fdfcb11", name: "Joe")
        let moveOption = MoveOption.rock
        let move = Move(player: player, move: moveOption)

        XCTAssertEqual(move.playerId, player.id)
        XCTAssertEqual(move.move, moveOption.rawValue)
    }
}
