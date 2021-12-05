//
//  ViewController.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//
import SnapKit
import UIKit

class AnswerViewController: UIViewController {

    private let answerVM: AnswerVM
    private let messageLabel = UILabel()
    private let magicLabel = UILabel()
    private let imageView = UIImageView()

    init(answerVM: AnswerVM) {
        self.answerVM = answerVM
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
        messageLabel.text = L10n.FirstResponse.title
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = L10n.Motion.Began.title
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            answerVM.getValue { [weak self] value in
                DispatchQueue.main.async {
                    self?.messageLabel.text = value
                    self?.answerVM.addAnswer(answer: value)
                }
            }
        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = L10n.Cancelled.title
    }

    private func adjustUI() {
        view.backgroundColor = .systemBackground

        magicLabel.text = L10n.Magic.label
        magicLabel.font = UIFont(name: L10n.Magic.font, size: 30)
        view.addSubview(magicLabel)
        magicLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }

        imageView.image =  UIImage(named: Asset.ball.name)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualTo(magicLabel).offset(45)
            make.bottom.lessThanOrEqualTo(30)
            make.leading.greaterThanOrEqualTo(5)
            make.trailing.lessThanOrEqualTo(5)
            make.width.equalTo(imageView.snp.height)
            make.width.height.equalToSuperview().priority(.high)
            make.height.lessThanOrEqualTo(view.frame.size.height)
        }

        messageLabel.numberOfLines = 0
        messageLabel.textColor = .systemBackground
        messageLabel.font = UIFont(name: L10n.Magic.font, size: 13)
        messageLabel.textAlignment = .center
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(imageView).inset(30)
            make.center.equalTo(imageView)
        }
    }
}
