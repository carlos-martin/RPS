//
//  MoveOptionTests.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest
@testable import RPS

final class MoveOptionTests: XCTestCase {

    func testInitFromDescription() {
        XCTAssertEqual(MoveOption(description: "👊"), .rock)
        XCTAssertEqual(MoveOption(description: "🖐️"), .paper)
        XCTAssertEqual(MoveOption(description: "✌️"), .scissor)
        XCTAssertEqual(MoveOption(description: ""), .none)
        XCTAssertEqual(MoveOption(description: "INVALID"), .none)
    }

    func testRawValues() {
        XCTAssertEqual(MoveOption.rock.rawValue, "ROCK")
        XCTAssertEqual(MoveOption.paper.rawValue, "PAPER")
        XCTAssertEqual(MoveOption.scissor.rawValue, "SCISSOR")
        XCTAssertEqual(MoveOption.none.rawValue, "")
    }

    func testDescriptions() {
        XCTAssertEqual(MoveOption.rock.description, "👊")
        XCTAssertEqual(MoveOption.paper.description, "🖐️")
        XCTAssertEqual(MoveOption.scissor.description, "✌️")
        XCTAssertEqual(MoveOption.none.description, "")
    }

    func testCases() {
        let cases = MoveOption.cases
        XCTAssertEqual(cases, ["👊", "🖐️", "✌️", ""])
    }

}
