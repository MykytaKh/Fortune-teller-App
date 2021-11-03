//
//  ViewController.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//

import UIKit
import Alamofire


let keyToAnwers = "keyToAnwers"

class ViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    var answers = [String]()
    let defaultAnswers = ["It is certain",
                          "It is decidedly so",
                          "Without a doubt",
                          "Yes, definitely",
                          "You may rely on it",
                          "As I see it, yes",
                          "Most likely",
                          "Outlook good",
                          "Yes",
                          "Signs point to yes",
                          "Reply hazy try again",
                          "Ask again later",
                          "Better not tell you now",
                          "Cannot predict now",
                          "Concentrate and ask again",
                          "Don't count on it",
                          "My reply is no",
                          "My sources say no",
                          "Outlook not so good",
                          "Very doubtful"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Ask any question and Shake me!"
        if let answers = UserDefaults.standard.array(forKey: keyToAnwers) as? [String] {
            self.answers = answers
        }
    }
    
    func showRandomAnswer() {
        DispatchQueue.main.async {
            if self.answers.isEmpty {
                self.messageLabel.text = self.defaultAnswers.randomElement()
            } else {
                self.messageLabel.text = self.answers.randomElement()
            }
        }
    }
    
    func sendRequest() {
        let urlString = "https://8ball.delegator.com/magic/JSON/question_string"
        
        guard let url = URL(string: urlString) else {
            self.showRandomAnswer()
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            if let error = error {
                print(error)
                self.showRandomAnswer()
                return
            }
            if let status = (response as? HTTPURLResponse)?.statusCode, status != 200 {
                self.showRandomAnswer()
                return
            }
            guard let data = data else {
                self.showRandomAnswer()
                return
            }
            do {
                guard let parsedJsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    self.showRandomAnswer()
                    return
                }
                
                if let magic = parsedJsonData["magic"] as? [String: Any],
                   let answer = magic["answer"] as? String {
                    DispatchQueue.main.async {
                        self.messageLabel.text = answer
                    }
                }
            } catch {
                self.showRandomAnswer()
                print(error)
            }
            
        }.resume()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = "Look into the future"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            sendRequest()
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = "Try again"
    }
    
}


