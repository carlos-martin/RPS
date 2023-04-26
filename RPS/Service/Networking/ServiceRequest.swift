//
//  ServiceRequest.swift
//  RPS
//
//  Created by Carlos Martin on 2023-04-25.
//

import Foundation

class ServiceRequest {
    static func make(for query: Requestable, completion: @escaping (String?, HTTPStatusResponse, Error?) -> Void) {
        var request = URLRequest(url: query.url, timeoutInterval: Double.infinity)
        request.httpMethod = query.method.value

        if let parameters = query.parameters, query.method == .post {
            let postData = parameters.data(using: .utf8)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = postData
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .undefined, error)
                return
            }
            let statusResponse = HTTPStatusResponse(httpResponse.statusCode)
            completion(String(data: data, encoding: .utf8), statusResponse, error)
        }

        task.resume()
    }
}
