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
    private var settingsVM: SettingsVM
    private let answersTableView = UITableView()
    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)

    init(settingsVM: SettingsVM) {
        self.settingsVM = settingsVM
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsVM.getAnswers().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let index = indexPath.row
        let answers = settingsVM.getAnswers()
        if   index < answers.count {
            cell.textLabel?.text = answers[index]
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var answers = settingsVM.getAnswers()
        if editingStylefor == .delete, index < answers.count {
            answers.remove(at: index)
            settingsVM.setAnswers(answers: answers)
            answersTableView.reloadData()
        }
    }
    @objc private func buttonTapped(_ sender: Any) {
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
        adjustUI()
        answersTableView.reloadData()
    }
    private func adjustUI() {
        title = L10n.Settings.title
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
