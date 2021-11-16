//
//  SettingsView.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation
import UIKit

class SettingsView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var answersTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    var settingsVM: SettingsVM?
    func didLoad() {
        settingsVM = SettingsVM(dbService: DBService())
        answersTableView.reloadData()
    }
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
            settingsVM.setAnswers(value: answers)
            answersTableView.reloadData()
        }
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let settingsVM = settingsVM else {
            return
        }
        if let answer = inputTextField.text, !answer.isEmpty {
            var answers = settingsVM.getAnswers()
            answers.append(answer)
            settingsVM.setAnswers(value: answers)
            answersTableView.reloadData()
            inputTextField.text = ""
            inputTextField.resignFirstResponder()
        }
    }
}
