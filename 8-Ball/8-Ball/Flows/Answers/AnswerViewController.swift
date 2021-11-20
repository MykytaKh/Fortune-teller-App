//
//  ViewController.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//
import SnapKit
import UIKit

class AnswerViewController: UIViewController {
    let messageLabel = UILabel()
    private let answerVM: AnswerVM
    init(answerVM: AnswerVM) {
        self.answerVM = answerVM
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         initialize()
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
                }
            }
        }
    }
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageLabel.text = L10n.Cancelled.title
    }
    private func initialize() {
        view.backgroundColor = .systemBackground
        let label = UILabel()
        label.text = "Magic 8 Ball"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }

        let imageView = UIImageView()
        imageView.image = UIImage(named: "emb")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(label).offset(45)
            make.bottom.lessThanOrEqualTo(30)
            make.leading.greaterThanOrEqualTo(5)
            make.trailing.lessThanOrEqualTo(5)
            make.width.equalTo(imageView.snp.height)
            make.width.height.equalToSuperview().priority(.high)
            make.height.lessThanOrEqualTo(view.frame.size.height)
        }

        messageLabel.numberOfLines = 0
        messageLabel.textColor = .systemBackground
        messageLabel.font = UIFont.boldSystemFont(ofSize: 30)
        messageLabel.textAlignment = .center
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(imageView).inset(30)
            make.centerY.centerX.equalTo(imageView)
        }
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("", for: .normal)
        let imagge = UIImage(systemName: "gearshape.fill")
        settingsButton.setImage(imagge?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        settingsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc private func buttonTapped() {
let settingsVC = SettingsVC()
        navigationController?.pushViewController(settingsVC, animated: true)        
    }
}
