//
//  SettingsViewController.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 19.10.2021.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

class SettingsViewController: UIViewController {
    
    private let settingsViewModel: SettingsViewModel
    private let answersTableView = UITableView()
    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)
    private let userAnswerSubject = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
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
    
    private func prepareUI() {
        view.backgroundColor = .systemBackground
        prepareTextField()
        prepareSaveButton()
        prepareAnswersTableView()
    }
    
    private func prepareTextField() {
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
    }
    
    private func prepareSaveButton() {
        saveButton.setTitle(L10n.SaveButton.title, for: .normal)
        saveButton.backgroundColor = .label
        saveButton.tintColor = .systemBackground
        saveButton.layer.cornerRadius = 8
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.centerY.height.equalTo(textField)
            make.left.equalTo(textField.snp.right).offset(15)
            make.width.equalTo(60)
        }
    }
    
    private func prepareAnswersTableView() {
        view.addSubview(answersTableView)
        answersTableView.snp.makeConstraints { make in
            make.top.equalTo(textField).inset(40)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        answersTableView.delegate = self
        answersTableView.dataSource = self
    }
    
    private func prepareSubscribers() {
        userAnswerSubject.subscribe(onNext: { [weak self] userAnswer in
            guard let self = self else { return }
            self.settingsViewModel.saveUserAnswer(userAnswer)
            self.answersTableView.reloadData()
        }).disposed(by: disposeBag)
        
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if let answer = self.textField.text, !answer.isEmpty {
                    self.userAnswerSubject.accept(answer)
                    self.textField.text = ""
                    self.textField.resignFirstResponder()
                }
            }).disposed(by: disposeBag)
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsViewModel.getUserAnswers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let index = indexPath.row
        let answers = settingsViewModel.getUserAnswers()
        if index < answers.count {
            let answer = answers[index]
            cell.textLabel?.text = answer.value
            cell.detailTextLabel?.text = answer.formattedDate
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let answers = settingsViewModel.getUserAnswers()
        if editingStylefor == .delete, index < answers.count {
            let deletedAnswer = answers[index]
            settingsViewModel.deleteUserAnswer(deletedAnswer)
            answersTableView.reloadData()
        }
    }
    
}
