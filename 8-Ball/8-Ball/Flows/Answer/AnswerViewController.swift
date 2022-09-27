//
//  ViewController.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 18.10.2021.
//
import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

class AnswerViewController: UIViewController {
    
    private let answerViewModel: AnswerViewModel
    private let messageLabel = UILabel()
    private let magicLabel = UILabel()
    private let magicBall = UIImageView()
    private let magicTriangle = UIImageView()
    private let labelSubject = PublishRelay<String>()
    private let motionSubject = PublishRelay<UIEvent.EventSubtype>()
    private let disposeBag = DisposeBag()
    
    init(answerViewModel: AnswerViewModel) {
        self.answerViewModel = answerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareSubscribers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        labelSubject.accept(L10n.FirstResponse.title)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        labelSubject.accept(L10n.Motion.Began.title)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionSubject.accept(.motionShake)
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        labelSubject.accept(L10n.Cancelled.title)
    }
    
    private func prepareSubscribers() {
        labelSubject
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        motionSubject
            .filter { $0 == .motionShake }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.animateMagicBall()
                self.animateMagicTriangle()
                self.answerViewModel.getNewAnswer()
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { answer in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                            guard let self = self else { return }
                            self.labelSubject.accept(answer)
                            self.answerViewModel.addAnswer(answer)
                            self.stopAnimating()
                            self.animateMessageLabel()
                        }
                    }).disposed(by: self.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    private func prepareUI() {
        view.backgroundColor = .systemBackground
        prepareMagicLabel()
        prepareMagicBall()
        prepareMagicTriangle()
        prepareMessageLabel()
    }
    
    private func prepareMagicLabel() {
        magicLabel.text = L10n.Magic.label
        magicLabel.font = UIFont(name: L10n.Magic.font, size: 30)
        view.addSubview(magicLabel)
        magicLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    private func prepareMagicBall() {
        magicBall.image =  UIImage(named: Asset.ball.name)
        view.addSubview(magicBall)
        magicBall.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualTo(magicLabel).offset(45)
            make.bottom.lessThanOrEqualTo(30)
            make.leading.greaterThanOrEqualTo(5)
            make.trailing.lessThanOrEqualTo(5)
            make.width.equalTo(magicBall.snp.height)
            make.width.height.equalToSuperview().priority(.high)
            make.height.lessThanOrEqualTo(view.frame.size.height)
        }
    }
    
    private func prepareMagicTriangle() {
        view.addSubview(magicTriangle)
        magicTriangle.snp.makeConstraints { make in
            make.center.equalTo(magicBall)
        }
    }
    
    private func prepareMessageLabel() {
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .systemBackground
        messageLabel.font = UIFont(name: L10n.Magic.font, size: 13)
        messageLabel.textAlignment = .center
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(magicBall).inset(30)
            make.center.equalTo(magicBall)
        }
    }
    
    private func animateMagicBall() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) {
            self.magicBall.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }
    
    private func animateMagicTriangle() {
        magicTriangle.animationImages = animateImages(for: L10n.Triangle.name)
        magicTriangle.animationDuration = 0.5
        magicTriangle.animationRepeatCount = 100
        magicTriangle.image = magicTriangle.animationImages?.first
        magicTriangle.startAnimating()
    }
    
    private func animateImages(for name: String) -> [UIImage] {
        var number = 0
        var images = [UIImage]()
        while let image = UIImage(named: "\(name)\(number)") {
            images.append(image)
            number += 1
        }
        return images
    }
    
    private func stopAnimating() {
        UIView.animate(withDuration: 0, animations: {
            self.magicBall.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        self.magicTriangle.stopAnimating()
    }
    
    private func animateMessageLabel() {
        self.messageLabel.isHidden = false
        UIView.animate(withDuration: 6) {
            self.messageLabel.transform = CGAffineTransform(scaleX: 6, y: 6)
        }
        UIView.animate(withDuration: 7) {
            self.messageLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}