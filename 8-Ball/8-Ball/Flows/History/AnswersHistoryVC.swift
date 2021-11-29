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
    private var answersHistoryVM: AnswersHistoryVM
    var answers: [ManagedAnswer] {
        return answersHistoryVM.getAnswers()
    }

    init(answersHistoryVM: AnswersHistoryVM) {
        self.answersHistoryVM = answersHistoryVM
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let index = indexPath.row
        let name = ("\(self.answers[index].name) (\(self.answers[index].date))")
        cell.textLabel?.text = name
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if editingStylefor == .delete, index < answers.count {
            answersHistoryVM.deleteAnswer(index: index)
            self.answersTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        answersTableView.reloadData()
    }
    private func adjustUI() {
        title = L10n.AnswersHistory.title
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
