//
//  GameTests.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest
@testable import RPS

final class GameTests: XCTestCase {
    let player1 = Player(id: "1", name: "Player 1")
    let player2 = Player(id: "2", name: "Player 2")

    //MARK: Init
    func testInitWithValidJson() throws {
        let jsonString = loadJsonStringFromFile("game_valid")
        guard let game = Game.fromSingleJson(jsonString) else {
            XCTFail()
            return
        }

        XCTAssertEqual(game.id, "378c576f-d4d3-4c67-9d00-7f7667a3d104")
        XCTAssertEqual(game.player1?.id, "627023a1-7fc4-417d-8828-6acd25e92689")
        XCTAssertEqual(game.player2?.id, "98ddc18c-2cc6-43d8-bcb0-c174ad2a6972")
        XCTAssertNil(game.currentRound)
        XCTAssertEqual(game.finishedRounds.count, 1)
        XCTAssertEqual(game.finishedRounds[0].id, "22b0073a-0359-4378-b937-747e5eb4e0b2")
        XCTAssertEqual(game.finishedRounds[0].player1Move, .rock)
        XCTAssertEqual(game.finishedRounds[0].player2Move, .paper)
    }

    func testInitWithInvalidJson() throws {
        let jsonString = loadJsonStringFromFile("game_invalid")
        let game = Game.fromSingleJson(jsonString)
        XCTAssertNil(game)
    }

    //MARK: hasAvailablePlace()
    func testHasAvailablePlaceWithNoPlayers() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertTrue(game.hasAvailablePlace())
    }

    func testHasAvailablePlaceWithOnePlayer() {
        var game = Game(id: "123", player1: player1, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertTrue(game.hasAvailablePlace())

        game.player2 = Player(id: "2", name: "Player 2")
        XCTAssertFalse(game.hasAvailablePlace())
    }

    func testHasAvailablePlaceWithTwoPlayers() {
        let game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: [])
        XCTAssertFalse(game.hasAvailablePlace())
    }

    //MARK: playerNumber(_ player: Player) -> GamePlayerNumber
    func testPlayerNumberWithNoPlayers() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.playerNumber(Player(id: "1", name: "Player 1")), .two)
    }

    func testPlayerNumberWithOnePlayer() {
        var game = Game(id: "123", player1: player1, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.playerNumber(player1), .one)

        game.player2 = Player(id: "2", name: "Player 2")
        XCTAssertEqual(game.playerNumber(player1), .one)
        XCTAssertEqual(game.playerNumber(game.player2!), .two)
    }

    func testPlayerNumberWithTwoPlayers() {
        let game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.playerNumber(player1), .one)
        XCTAssertEqual(game.playerNumber(player2), .two)
    }

    //MARK: getTheOpponentOf(_ player: Player) -> Player?
    func testGetTheOpponentOfWithNoPlayers() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertNil(game.getTheOpponentOf(Player(id: "1", name: "Player 1")))
    }

    func testGetTheOpponentOfWithOnePlayer() {
        var game = Game(id: "123", player1: player1, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertNil(game.getTheOpponentOf(player1))
    }

    func testGetTheOpponentOfWithTwoPlayers() {
        let game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.getTheOpponentOf(player1), player2)
        XCTAssertEqual(game.getTheOpponentOf(player2), player1)
    }

    //MARK: playerMove(_ player: Player, roundId: String) -> String
    func testPlayerMoveWithNoCurrentRound() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        //let player1 = Player(id: "1", name: "Player 1")
        let roundId = "round1"
        XCTAssertEqual(game.playerMove(player1, roundId: roundId), "")
    }

    func testPlayerMoveWithCurrentRound() {
        let roundId = "round1"
        var round = Round(id: roundId, player1Move: .rock, player2Move: .paper)
        var game = Game(id: "123", player1: player1, player2: player2, currentRound: round, finishedRounds: [])
        XCTAssertEqual(game.playerMove(player1, roundId: roundId), MoveOption.rock.description)
        XCTAssertEqual(game.playerMove(player2, roundId: roundId), MoveOption.paper.description)

        round.player1Move = .paper
        round.player2Move = .scissor
        game.currentRound = round
        XCTAssertEqual(game.playerMove(player1, roundId: roundId), MoveOption.paper.description)
        XCTAssertEqual(game.playerMove(player2, roundId: roundId), MoveOption.scissor.description)
    }

    func testPlayerMoveWithFinishedRound() {
        let roundId1 = "round1"
        let roundId2 = "round2"
        var round1 = Round(id: roundId1, player1Move: .rock, player2Move: .paper)
        var round2 = Round(id: roundId2, player1Move: .paper, player2Move: .scissor)
        let finishedRounds = [round1, round2]
        let game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: finishedRounds)
        XCTAssertEqual(game.playerMove(player1, roundId: roundId1), MoveOption.rock.description)
        XCTAssertEqual(game.playerMove(player2, roundId: roundId1), MoveOption.paper.description)
        XCTAssertEqual(game.playerMove(player1, roundId: roundId2), MoveOption.paper.description)
        XCTAssertEqual(game.playerMove(player2, roundId: roundId2), MoveOption.scissor.description)
    }

    //MARK: isTheWinner(_ player: Player, roundId: String) -> Bool
    func testIsTheWinnerWithNoRound() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        //let player1 = Player(id: "1", name: "Player 1")
        let roundId = "round1"
        XCTAssertFalse(game.isTheWinner(player1, roundId: roundId))
    }

    func testIsTheWinnerWithCurrentRound() {
        let roundId = "round1"
        var round = Round(id: roundId, player1Move: .rock, player2Move: .paper)
        var game = Game(id: "123", player1: player1, player2: player2, currentRound: round, finishedRounds: [])
        XCTAssertFalse(game.isTheWinner(player1, roundId: roundId))
        XCTAssertTrue(game.isTheWinner(player2, roundId: roundId))

        round.player1Move = .scissor
        round.player2Move = .paper
        game.currentRound = round
        XCTAssertTrue(game.isTheWinner(player1, roundId: roundId))
        XCTAssertFalse(game.isTheWinner(player2, roundId: roundId))
    }

    func testIsTheWinnerWithFinishedRound() {
        let roundId1 = "round1"
        let roundId2 = "round2"
        var round1 = Round(id: roundId1, player1Move: .rock, player2Move: .paper)
        var round2 = Round(id: roundId2, player1Move: .paper, player2Move: .scissor)
        let finishedRounds = [round1, round2]
        let game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: finishedRounds)
        XCTAssertFalse(game.isTheWinner(player1, roundId: roundId1))
        XCTAssertTrue(game.isTheWinner(player2, roundId: roundId1))
        XCTAssertFalse(game.isTheWinner(player1, roundId: roundId2))
        XCTAssertTrue(game.isTheWinner(player2, roundId: roundId2))
    }

    //MARK: victories(_ player: Player) -> Int
    func testVictoriesWithNoPlayers() {
        let game = Game(id: "123", player1: nil, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.victories(player1), 0)
    }

    func testVictoriesWithOnePlayer() {
        var game = Game(id: "123", player1: player1, player2: nil, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.victories(player1), 0)
        XCTAssertEqual(game.victories(player2), 0)

        let roundId1 = "round1"
        let roundId2 = "round2"
        var round1 = Round(id: roundId1, player1Move: .rock, player2Move: .paper)
        var round2 = Round(id: roundId2, player1Move: .paper, player2Move: .scissor)
        round1.player1Move = .paper
        round1.player2Move = .rock
        round2.player1Move = .scissor
        round2.player2Move = .rock
        game.finishedRounds = [round1, round2]
        XCTAssertEqual(game.victories(player1), 0)
        XCTAssertEqual(game.victories(player2), 0)
    }

    func testVictoriesWithTwoPlayers() {
        var game = Game(id: "123", player1: player1, player2: player2, currentRound: nil, finishedRounds: [])
        XCTAssertEqual(game.victories(player1), 0)
        XCTAssertEqual(game.victories(player2), 0)

        let roundId1 = "round1"
        let roundId2 = "round2"
        var round1 = Round(id: roundId1, player1Move: .rock, player2Move: .paper)
        var round2 = Round(id: roundId2, player1Move: .paper, player2Move: .scissor)

        round1.player1Move = .paper
        round1.player2Move = .rock
        round2.player1Move = .scissor
        round2.player2Move = .rock
        game.finishedRounds = [round1, round2]
        XCTAssertEqual(game.victories(player1), 1)
        XCTAssertEqual(game.victories(player2), 1)

        round1.player1Move = .rock
        round1.player2Move = .scissor
        round2.player1Move = .scissor
        round2.player2Move = .rock
        game.finishedRounds += [round1, round2]
        XCTAssertEqual(game.victories(player1), 2)
        XCTAssertEqual(game.victories(player2), 2)

        round1.player1Move = .scissor
        round1.player2Move = .rock
        round2.player1Move = .rock
        round2.player2Move = .paper
        game.finishedRounds += [round1, round2]
        XCTAssertEqual(game.victories(player1), 2)
        XCTAssertEqual(game.victories(player2), 4)
    }
}
