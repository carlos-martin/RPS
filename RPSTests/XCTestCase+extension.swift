//
//  XCTestCase+extension.swift
//  RPSTests
//
//  Created by Carlos Martin on 2023-05-10.
//

import XCTest

extension XCTestCase {
    func loadJsonStringFromFile(_ filename: String) -> String {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Missing file: \(filename).json")
        }

        do {
            let data = try Data(contentsOf: url)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                fatalError("Unable to convert data to string: \(filename).json")
            }
            return jsonString
        } catch {
            fatalError("Unable to read file: \(filename).json, error: \(error)")
        }
    }
}

