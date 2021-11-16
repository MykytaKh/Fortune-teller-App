//
//  ViewController.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet var answerView: AnswerView!
    private var answerManager: AnswerManager!
    func setAnswerManager(_ value: AnswerManager) {
        self.answerManager = value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        answerView.setLabel(text: L10n.FirstResponse.title)
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerView.setLabel(text: L10n.Motion.Began.title)
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            answerManager.fetchAnswer { [weak self] answer in
                DispatchQueue.main.async {
                    self?.answerView.setLabel(text: answer)
                }
            } failure: { [weak self] in
                DispatchQueue.main.async {
                    self?.answerView.setLabel(text: L10n.Cancel.Error.title)
                }
            }
        }
    }
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerView.setLabel(text: L10n.Cancelled.title)
    }
}
