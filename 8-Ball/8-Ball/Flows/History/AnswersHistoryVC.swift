//
//  AnswersHistoryVC.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import UIKit
import SnapKit

class AnswersHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let answersTableView = UITableView()
    private let answersHistoryVM: AnswersHistoryVM
    private var answers = [HistoryAnswerModel]()

    init(answersHistoryVM: AnswersHistoryVM) {
        self.answersHistoryVM = answersHistoryVM
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAnswers()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let index = indexPath.row
        if index < answers.count {
            let answer = self.answers[index]
            cell.textLabel?.text = answer.value
            cell.detailTextLabel?.text = answer.formattedDate
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if editingStylefor == .delete, index < answers.count {
            answersHistoryVM.deleteAnswer(answers[index])
            answers.remove(at: index)
            self.answersTableView.reloadData()
        }
    }

    func fetchAnswers() {
        answersHistoryVM.fetchAnswers { [weak self] answers in
            guard let self = self else { return }
            self.answers = answers
            DispatchQueue.main.async {
                self.answersTableView.reloadData()
            }
        }
    }

    private func adjustUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(answersTableView)
        answersTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        answersTableView.delegate = self
        answersTableView.dataSource = self
    }
}
