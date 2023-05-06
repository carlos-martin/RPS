//
//  String+extension.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-06.
//

import Foundation

extension String {
    struct Onboard {
        static var newGame: String = "New Game"
        static var joinGame: String = "Join a Game"
    }
    struct Game {
        static var activeGame: String = "Active Game"
        static var noMovement: String = "No movement"
        static var waitingForYou: String = "Waiting for you"

        struct Summary {
            static var waitingForOpponent: String = "Waiting for an opponent"
            static func waitingForAMove(of name: String) -> String {
                "Waiting for \(name) to move"
            }
            static var winner: String = "Winner!! 🏆"
            static var loser: String = "Loser!! 💩"
        }
    }

    struct Player {
        static var noName: String = "No player"
        static var one: String = "Player 1"
        static var two: String = "Player 2"
        static var you: String = "(you)"
    }
    struct Button {
        static var submit: String = "Submit"
    }
    struct TextField {
        static var title: String = "Player name"
        static var placeholder: String = "Enter your name"
    }
    struct Alert {
        struct Generic {
            static var title: String = "Oops"
            static var message: String = "Something went wrong, try it again latter."
            static var button: String = "OK"
        }
        struct NoGames {
            static var title: String = "Oops"
            static var message: String = "No games available, try again later or create a new game."
            static var button: String = "OK"
        }
    }
}
