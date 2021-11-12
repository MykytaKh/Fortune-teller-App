//
//  ViewController.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    private var answerManager: AnswerManager!

    func setAnswerManager(_ value: AnswerManager) {
        self.answerManager = value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Ask any question and Shake me!"
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = "Look into the future"
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            answerManager.fetchAnswer { [weak self] answer in
                DispatchQueue.main.async {
                    self?.messageLabel.text = answer
                }
            } failure: { [weak self] in
                DispatchQueue.main.async {
                    self?.messageLabel.text = "Error! Try again later!"
                }
            }
        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = "Try again"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let settingsVC = segue.destination as? SettingsVC else {
            return
        }
        settingsVC.setDbService(DBService())
    }
}
