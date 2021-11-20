//
//  SettingsVC.swift
//  8-Ball
//
//  Created by Никита Хламов on 19.10.2021.
//

import Foundation
import UIKit
import SnapKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var settingsVM: SettingsVM?
    private var answersTableView = UITableView()
    private var textField = UITextField()
    private var saveButton = UIButton(type: .system)

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsVM?.getAnswers().count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let index = indexPath.row
        if let answers = settingsVM?.getAnswers(),
           index < answers.count {
            cell.textLabel?.text = answers[index]
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let settingsVM = settingsVM else {
            return
        }
        var answers = settingsVM.getAnswers()
        if editingStylefor == .delete, index < answers.count {
            answers.remove(at: index)
            settingsVM.setAnswers(answers: answers)
            answersTableView.reloadData()
        }
    }
    @objc private func buttonTapped(_ sender: Any) {
        guard let settingsVM = settingsVM else {
            return
        }

        if let answer = textField.text, !answer.isEmpty {
            var answers = settingsVM.getAnswers()
            answers.append(answer)
            settingsVM.setAnswers(answers: answers)
            answersTableView.reloadData()
            textField.text = ""
            textField.resignFirstResponder()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsVM = SettingsVM()
        adjustUI()
        answersTableView.reloadData()
    }
    private func adjustUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
        textField.borderStyle = .roundedRect

        saveButton.setTitle(L10n.SaveButton.title, for: .normal)
        saveButton.backgroundColor = .label
        saveButton.tintColor = .systemBackground
        saveButton.layer.cornerRadius = 8

               view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.left.equalTo(textField.snp.right).inset(-15)
            make.height.equalTo(textField)
            make.width.equalTo(60)
               }
        saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(answersTableView)
        answersTableView.snp.makeConstraints { make in
            make.top.equalTo(textField).inset(40)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        answersTableView.delegate = self
        answersTableView.dataSource = self
    }
}
