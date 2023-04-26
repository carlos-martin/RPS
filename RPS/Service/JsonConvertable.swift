//
//  JsonConvertable.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

protocol JsonConvertable: Codable {
    func toJson() -> String?
    static func fromSingleJson(_ jsonString: String) -> Self?
    static func fromArrayJson(_ jsonString: String) -> [Self]?
}

extension JsonConvertable {
    func toJson() -> String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return nil
            }
            return jsonString
        } catch {
            print("Error encoding \(type(of: self)) to JSON: \(error.localizedDescription)")
            return nil
        }
    }

    static func fromSingleJson(_ jsonString: String) -> Self? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            print("Error parsing single JSON data: \(error.localizedDescription)")
            return nil
        }
    }

    static func fromArrayJson(_ jsonString: String) -> [Self]? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        do {
            return try JSONDecoder().decode([Self].self, from: jsonData)
        } catch {
            print("Error parsing array JSON data: \(error.localizedDescription)")
            return nil
        }
    }
}
