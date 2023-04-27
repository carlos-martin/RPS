//
//  GameService.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-24.
//

import Foundation
import Combine

protocol GameServiceProtocol {
    func fetchAllGames(completion: @escaping ([Game], Error?) -> Void)
    func fetchGame(id: String, completion: @escaping (Game?, Error?) -> Void)
    func fetchRound(gameId: String, roundId: String, completion: @escaping (Round?, Error?) -> Void)
    func createGame(completion: @escaping (Game?, Error?) -> Void)
    func addPlayer(to game: Game, name: String, completion: @escaping (Player?, Error?) -> Void)
    func gameMove(to game: Game, move: Move, completion: @escaping (Round?, Error?) -> Void)
}

class GameService: GameServiceProtocol {
    static let sharedInstance: GameServiceProtocol = GameService()

    func fetchAllGames(completion: @escaping ([Game], Error?) -> Void) {
        ServiceRequest.make(for: AllGamesQuery()) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion([], error)
                    return
                }
                let allGames = Game.fromArrayJson(jsonString) ?? []
                completion(allGames, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion([], nil)
            default:
                completion([], error)
            }
        }
    }

    func fetchGame(id: String, completion: @escaping (Game?, Error?) -> Void) {
        ServiceRequest.make(for: GameQuery(gameId: id)) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion(nil, error)
                    return
                }
                let game = Game.fromSingleJson(jsonString)
                completion(game, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion(nil, nil)
            default:
                completion(nil, error)
            }
        }
    }

    func fetchRound(gameId: String, roundId: String, completion: @escaping (Round?, Error?) -> Void) {
        ServiceRequest.make(for: RoundQuery(gameId: gameId, roundId: roundId)) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion(nil, error)
                    return
                }
                let round = Round.fromSingleJson(jsonString)
                completion(round, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion(nil, nil)
            default:
                completion(nil, error)
            }
        }
    }

    func createGame(completion: @escaping (Game?, Error?) -> Void) {
        ServiceRequest.make(for: NewGameQuery()) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion(nil, error)
                    return
                }
                let game = Game.fromSingleJson(jsonString)
                completion(game, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion(nil, nil)
            default:
                completion(nil, error)
            }
        }
    }

    func addPlayer(to game: Game, name: String, completion: @escaping (Player?, Error?) -> Void) {
        ServiceRequest.make(for: AddPlayerQuery(gameId: game.id, name: name)) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion(nil, error)
                    return
                }
                let player = Player.fromSingleJson(jsonString)
                completion(player, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion(nil, nil)
            default:
                completion(nil, error)
            }
        }
    }

    func gameMove(to game: Game, move: Move, completion: @escaping (Round?, Error?) -> Void) {
        ServiceRequest.make(for: GameMoveQuery(gameId: game.id, move: move)) { jsonString, statusCode, error in
            switch statusCode {
            case .success:
                guard let jsonString = jsonString else {
                    print(String(describing: error))
                    completion(nil, error)
                    return
                }
                let round = Round.fromSingleJson(jsonString)
                completion(round, nil)
            case .serverError:
                //TODO: handler 500, we need to try it again
                completion(nil, nil)
            default:
                completion(nil, error)
            }
        }
    }
}
