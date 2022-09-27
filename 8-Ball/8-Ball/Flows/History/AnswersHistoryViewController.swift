//
//  AnswersHistoryViewController.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 26.11.2021.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class AnswersHistoryViewController: UIViewController {
    
    private let answersHistoryViewModel: AnswersHistoryViewModel
    private let answersTableView = UITableView()
    private var notificationToken: NotificationToken?
    private var answers: [Answer] = []
    
    init(answersHistoryVM: AnswersHistoryViewModel) {
        self.answersHistoryViewModel = answersHistoryVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareNotification()
    }
    
    private func prepareUI() {
        view.backgroundColor = .systemBackground
        prepareAnswersTableView()
    }
    
    private func prepareAnswersTableView() {
        view.addSubview(answersTableView)
        answersTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        answersTableView.delegate = self
        answersTableView.dataSource = self
    }
    
}

extension AnswersHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
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
    
    func tableView(_ tableView: UITableView, commit editingStylefor: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if editingStylefor == .delete, index < answers.count {
            answersHistoryViewModel.deleteAnswer(answers[index])
        }
    }
    
}

extension AnswersHistoryViewController {
    
    private func prepareNotification() {
        let realm = try? Realm()
        let results = realm?.objects(ManagedAnswer.self)
        notificationToken = results?.observe { [weak self] _ in
            self?.fetchAnswers()
        }
    }
    
    private func fetchAnswers() {
        answersHistoryViewModel.fetchAnswers { [weak self] answers in
            guard let self = self else { return }
            self.answers = answers
            DispatchQueue.main.async {
                self.answersTableView.reloadData()
            }
        }
    }
    
}
