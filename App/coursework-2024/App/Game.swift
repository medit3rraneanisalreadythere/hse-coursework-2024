//
//  Game.swift
//  coursework-2024
//
//  Created by Таня Белка on 10.04.2024.
//

import UIKit

var cards: [String] = []

final class Game: UIViewController {
    private var addButton: UIButton!
    private var stopGameButton: UIButton!
//    private  // Массив для хранения текста карточек
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureAddButton()
        configureStopGameButton()
    }
    
    private func configureAddButton() {
        addButton = UIButton(type: .system)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 25
        addButton.backgroundColor = UIColor(hex: 0x007AFF)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addButtonTapped() {
        presentTextInputAlert()
    }
    
    private func configureStopGameButton() {
        stopGameButton = UIButton(type: .system)
        stopGameButton.setTitle("Остановить игру", for: .normal)
        stopGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        stopGameButton.setTitleColor(.white, for: .normal)
        stopGameButton.layer.cornerRadius = 25
        stopGameButton.backgroundColor = UIColor(hex: 0xFF3B30) // Красная кнопка
        stopGameButton.addTarget(self, action: #selector(stopGameButtonTapped), for: .touchUpInside)
        stopGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stopGameButton)
        
        NSLayoutConstraint.activate([
            stopGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stopGameButton.widthAnchor.constraint(equalToConstant: 200),
            stopGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func stopGameButtonTapped() {
        // Здесь логика для остановки игры
        let vc = Voting()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func presentTextInputAlert() {
        let alertController = UIAlertController(title: "Новая карточка", message: "Введите текст для карточки", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Текст"
        }
        
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            if let text = alertController.textFields?.first?.text, !text.isEmpty {
//                self?.cards.append(text)
                cards.append(text)
                // Здесь код для обновления интерфейса, если это необходимо
            } else {
                // Показываем ошибку, если поле пустое
                self?.presentErrorAlert()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func presentErrorAlert() {
        let errorAlertController = UIAlertController(title: "Ошибка", message: "Текст не может быть пустым", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            self?.presentTextInputAlert() // Предложение ввести текст снова
        }
        
        errorAlertController.addAction(okAction)
        
        present(errorAlertController, animated: true)
    }
}


final class Voting: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView: UITableView!
    private var stopVotingButton: UIButton!
    var options: [String] = ["Вариант 1", "Вариант 2"] // Пример данных
    
    var votesForOptions: [Int: Int] = [:] // Словарь для подсчета голосов
    var votesAgainstOptions: [Int: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x24232A)
        setupUI()
    }
    
    private func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VotingTableViewCell.self, forCellReuseIdentifier: "VotingCell")
        tableView.backgroundColor = UIColor(hex: 0x24232A)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        stopVotingButton = UIButton(type: .system)
        stopVotingButton.setTitle("Остановить голосование", for: .normal)
        stopVotingButton.backgroundColor = UIColor(hex: 0xFF3B30)
        stopVotingButton.setTitleColor(.white, for: .normal)
        stopVotingButton.layer.cornerRadius = 10
        stopVotingButton.addTarget(self, action: #selector(stopVotingButtonTapped), for: .touchUpInside)
        stopVotingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopVotingButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: stopVotingButton.topAnchor, constant: -20),
            
            stopVotingButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stopVotingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stopVotingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stopVotingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VotingCell", for: indexPath) as? VotingTableViewCell else {
            return UITableViewCell()
        }
        cell.optionLabel.text = options[indexPath.row]
        cell.onVoteUp = {
            self.votesForOptions[indexPath.row, default: 0] += 1
        }
        cell.onVoteDown = {
            self.votesAgainstOptions[indexPath.row, default: 0] += 1
        }
        return cell
    }

    @objc private func stopVotingButtonTapped() {
        let maxVotes = votesForOptions.values.max() ?? 0
        let winners = votesForOptions.filter { $0.value == maxVotes }.map { $0.key }
        
        guard !winners.isEmpty else {
                print("No winners")
            
                let resultsVC = ResultsViewController()
                resultsVC.winnerOption = "Вариант 1"
                resultsVC.modalPresentationStyle = .fullScreen // Изменено для полного экрана
                present(resultsVC, animated: true, completion: nil)
                return
            }
        
        let winnerIndex = winners.randomElement() ?? 0
        let winnerOption = options[winnerIndex]
        
        let resultsVC = ResultsViewController()
        resultsVC.winnerOption = winnerOption
        resultsVC.modalPresentationStyle = .fullScreen // Изменено для полного экрана
        present(resultsVC, animated: true, completion: nil)
    }
}

class VotingTableViewCell: UITableViewCell {
    let optionLabel = UILabel()
    let voteUpButton = UIButton(type: .system)
    let voteDownButton = UIButton(type: .system)

    var onVoteUp: (() -> Void)?
    var onVoteDown: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        
        // Настраиваем обработчики нажатий
        voteUpButton.addTarget(self, action: #selector(voteUpTapped), for: .touchUpInside)
        voteDownButton.addTarget(self, action: #selector(voteDownTapped), for: .touchUpInside)
    }
    
    @objc private func voteUpTapped() {
        onVoteUp?()
    }
    
    @objc private func voteDownTapped() {
        onVoteDown?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        backgroundColor = UIColor(hex: 0x24232A)

        optionLabel.textColor = .white
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(optionLabel)

        voteUpButton.setTitle("За", for: .normal)
        voteUpButton.backgroundColor = UIColor(hex: 0x007AFF)
        voteUpButton.setTitleColor(.white, for: .normal)
        voteUpButton.layer.cornerRadius = 10
        voteUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(voteUpButton)

        voteDownButton.setTitle("Против", for: .normal)
        voteDownButton.backgroundColor = UIColor(hex: 0xFF3B30)
        voteDownButton.setTitleColor(.white, for: .normal)
        voteDownButton.layer.cornerRadius = 10
        voteDownButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(voteDownButton)
        
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            voteUpButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            voteUpButton.trailingAnchor.constraint(equalTo: voteDownButton.leadingAnchor, constant: -10),
            voteUpButton.widthAnchor.constraint(equalToConstant: 60),
            
            voteDownButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            voteDownButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            voteDownButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}


final class ResultsViewController: UIViewController {
    var winnerOption: String?
    
    private let winnerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x24232A)
        setupUI()
    }
    
    private func setupUI() {
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
        winnerLabel.textColor = .white
        winnerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        winnerLabel.textAlignment = .center
        winnerLabel.text = "Победитель: \(winnerOption ?? "Не определен")"
        view.addSubview(winnerLabel)
        
        NSLayoutConstraint.activate([
            winnerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winnerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
