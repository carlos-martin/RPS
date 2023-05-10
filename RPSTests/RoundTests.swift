//
//  RoundTests.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest

class RoundTests: XCTestCase {
    func testRoundFromJSON() throws {
        let jsonString = loadJsonStringFromFile("round_valid")
        guard let round = Round.fromSingleJson(jsonString) else {
            XCTFail()
            return
        }
        XCTAssertEqual(round.id, "22b0073a-0359-4378-b937-747e5eb4e0b2")
        XCTAssertEqual(round.player1Move, .rock)
        XCTAssertEqual(round.player2Move, .paper)
    }

    func testRoundFromInvalidJSON() throws {
        let jsonString = loadJsonStringFromFile("round_invalid")
        let round = Round.fromSingleJson(jsonString)
        XCTAssertNil(round)
    }

    func testRoundWinnerRockVsScissor() {
        let round1 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .rock, player2Move: .scissor)
        XCTAssertEqual(round1.winner(), .one)
    }

    func testRoundWinnerPaperVsRock() {
        let round2 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .paper, player2Move: .rock)
        XCTAssertEqual(round2.winner(), .one)
    }

    func testRoundWinnerScissorVsPaper() {
        let round3 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .scissor, player2Move: .paper)
        XCTAssertEqual(round3.winner(), .one)
    }

    func testRoundWinnerScissorVsRock() {
        let round6 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .scissor, player2Move: .rock)
        XCTAssertEqual(round6.winner(), .two)
    }

    func testRoundNoWinnerBacauseATie() {
        let round4 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .rock, player2Move: .rock)
        XCTAssertNil(round4.winner())
    }

    func testRoundNoWinnerBecauseOnlyOnePlayer() {
        let round5 = Round(id: "ac265723-3eff-48cb-bbeb-04baf4b6eb28", player1Move: .rock, player2Move: nil)
        XCTAssertNil(round5.winner())
    }

}
