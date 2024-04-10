//
//  CreateGame.swift
//  coursework-2024
//
//  Created by Таня Белка on 10.04.2024.
//

import UIKit

final class CreateGame: UIViewController {
    private var headerView: UIView!
    private var titleLabel: UILabel!
    private var pinLabel: UILabel!
//    private var pinCodeLabel: UILabel!
    private var stackView: UIStackView!
    private var playerCountLabel: UILabel!
    private var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureHeader()
        configureTitleLabel()
        configurePinLabel()
        configurePinCodeLabel(pinCode: "1234")
        configurePlayerCountLabel()
        configureStartGameButton()
    }
    
    private func configureHeader() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Новая игра"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ])
    }
    
    private func configurePinLabel() {
        pinLabel = UILabel()
        pinLabel.text = "Пин-код комнаты"
        pinLabel.textColor = .white
        pinLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .semibold)
        pinLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinLabel)
        
        NSLayoutConstraint.activate([
            pinLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            pinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configurePinCodeLabel(pinCode: String) {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Создание отдельной UILabel для каждой цифры пин-кода
        for char in pinCode {
            let charLabel = UILabel()
            charLabel.text = String(char)
            charLabel.textColor = .white
            charLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .bold)
            charLabel.backgroundColor = UIColor(hex: 0x292830)
            charLabel.textAlignment = .center
            charLabel.layer.cornerRadius = 8
            charLabel.clipsToBounds = true
            charLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
            charLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            stackView.addArrangedSubview(charLabel)
        }

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: pinLabel.bottomAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePlayerCountLabel() {
        playerCountLabel = UILabel()
        playerCountLabel.text = "Игроки: 1"
        playerCountLabel.textColor = .white
        playerCountLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        playerCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerCountLabel)
        
        NSLayoutConstraint.activate([
            playerCountLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            playerCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureStartGameButton() {
        startGameButton = UIButton(type: .system)
        startGameButton.setTitle("Начать игру", for: .normal)
        startGameButton.backgroundColor = UIColor(hex: 0x007AFF)
        startGameButton.setTitleColor(.white, for: .normal)
        startGameButton.layer.cornerRadius = 25
        startGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        startGameButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startGameButton)
        
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(equalTo: playerCountLabel.bottomAnchor, constant: 90),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalToConstant: 200),
            startGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func startGameButtonTapped() {
        // Действие для старта игры
        let vc = Game()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
