//
//  SettingsVC.swift
//  8-Ball
//
//  Created by Никита Хламов on 19.10.2021.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var answersTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    private var answers = [String]()
    private var dbService: DBService!
    
    func setDbService(_ value: DBService) {
        self.dbService = value
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let answer = inputTextField.text, !answer.isEmpty {
            answers.append(answer)
            answersTableView.reloadData()
            inputTextField.text = ""
            inputTextField.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let index = indexPath.row
        if index < answers.count {
            cell.textLabel?.text = answers[index]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if editingStylefor == .delete, index < answers.count {
            answers.remove(at: index)
            answersTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dbService.saveUserAnswers(array: answers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answers = dbService.getUserAnswers()
        answersTableView.reloadData()
    }
}
