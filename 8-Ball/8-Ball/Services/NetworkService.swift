//
//  Network.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation
import RxSwift

protocol NetworkProtocol {
    func fetchResponse() -> Observable<String>
}

class NetworkService: NetworkProtocol {
    
    private let urlString: String
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlString = "https://8ball.delegator.com/magic/JSON/question_string"
        self.urlSession = urlSession
    }

    func fetchResponse() -> Observable<String> {
        return Observable.create { observer in
            guard let url = URL(string: self.urlString) else {
                return Disposables.create()
            }
            self.urlSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                if let status = (response as? HTTPURLResponse)?.statusCode, status != 200 {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    guard let parsedJsonData = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                return
                            }
                    if let magic = parsedJsonData["magic"] as? [String: Any],
                       let answer = magic["answer"] as? String {
                        observer.onNext(answer)
                    } else {
                    }
                } catch {
                    print(error)
                }
            } .resume()
            return Disposables.create()
        }
    }
}
