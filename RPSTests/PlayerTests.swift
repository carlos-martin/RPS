//
//  PlayerTests.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest
@testable import RPS

class PlayerTests: XCTestCase {
    func testPlayerFromJSON() throws {
        let jsonString = loadJsonStringFromFile("player_valid")
        guard let player = Player.fromSingleJson(jsonString) else {
            XCTFail()
            return
        }
        XCTAssertEqual(player.id, "6ef3a61c-c65f-42cc-9673-88c15fdfcb11")
        XCTAssertEqual(player.name, "Joe")
    }

    func testPlayerFromInvalidJSON() throws {
        let jsonString = loadJsonStringFromFile("player_invalid")
        let player = Player.fromSingleJson(jsonString)

        XCTAssertNil(player)
    }
}
