//
//  Network.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func fetchResponse(success: @escaping (String) -> Void, failure: @escaping () -> Void)
}

class Network: NetworkProtocol {

    private let urlString: String
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlString = "https://8ball.delegator.com/magic/JSON/question_string"
        self.urlSession = urlSession
    }

    func fetchResponse(success: @escaping (String) -> Void, failure: @escaping () -> Void) {

        guard let url = URL(string: self.urlString) else {
            failure()
            return
        }
        self.urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                failure()
                return
            }
            if let status = (response as? HTTPURLResponse)?.statusCode, status != 200 {
                failure()
                return
            }
            guard let data = data else {
                failure()
                return
            }
            do {
                guard let parsedJsonData = try JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any] else {
                    failure()
                    return
                }
                if let magic = parsedJsonData["magic"] as? [String: Any],
                   let answer = magic["answer"] as? String {
                    success(answer)
                } else {
                    failure()
                }
            } catch {
                failure()
                print(error)
            }
        }.resume()
    }
}
