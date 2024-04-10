//
//  JoinGame.swift
//  coursework-2024
//
//  Created by Таня Белка on 10.04.2024.
//

import UIKit

final class JoinGame: UIViewController {
    private var headerView: UIView!
    private var titleLabel: UILabel!
    private var pinLabel: UILabel!
    private var pinEntryStackView: UIStackView!
//    private var playerCountLabel: UILabel!
    private var joinGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureHeader()
        configureTitleLabel()
        configurePinLabel()
        configurePinEntryFields()
//        configurePlayerCountLabel()
        configureJoinGameButton()
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
        titleLabel.text = "Существующая игра"
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
    
    // ... Здесь остальной код (configureHeader, configureTitleLabel, configurePlayerCountLabel) ...
    
    private func configurePinEntryFields() {
        pinEntryStackView = UIStackView()
        pinEntryStackView.axis = .horizontal
        pinEntryStackView.distribution = .fillEqually
        pinEntryStackView.spacing = 10
        pinEntryStackView.translatesAutoresizingMaskIntoConstraints = false

        // Создание четырех UITextField для каждой цифры пин-кода
        for _ in 0..<4 {
            let pinEntryField = UITextField()
            pinEntryField.delegate = self
            pinEntryField.textColor = .white
            pinEntryField.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .bold)
            pinEntryField.backgroundColor = UIColor(hex: 0x292830)
            pinEntryField.textAlignment = .center
            pinEntryField.layer.cornerRadius = 8
            pinEntryField.keyboardType = .numberPad
            pinEntryField.clipsToBounds = true
            pinEntryField.translatesAutoresizingMaskIntoConstraints = false
            pinEntryField.widthAnchor.constraint(equalToConstant: 40).isActive = true
            pinEntryField.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            pinEntryStackView.addArrangedSubview(pinEntryField)
        }

        view.addSubview(pinEntryStackView)

        NSLayoutConstraint.activate([
            pinEntryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinEntryStackView.topAnchor.constraint(equalTo: pinLabel.bottomAnchor, constant: 40),
            pinEntryStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureJoinGameButton() {
        joinGameButton = UIButton(type: .system)
        joinGameButton.setTitle("Присоединиться", for: .normal)
        joinGameButton.backgroundColor = UIColor(hex: 0x007AFF)
        joinGameButton.setTitleColor(.white, for: .normal)
        joinGameButton.layer.cornerRadius = 25
        joinGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        joinGameButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        joinGameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(joinGameButton)
        
        NSLayoutConstraint.activate([
            joinGameButton.topAnchor.constraint(equalTo: pinEntryStackView.bottomAnchor, constant: 90),
            joinGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinGameButton.widthAnchor.constraint(equalToConstant: 220),
            joinGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // ... configureJoinGameButton и другие методы ...
    
    @objc private func startGameButtonTapped() {
        // Действие для старта игры
        
        let vc = WaitingForGame()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// Расширение для делегата UITextField для перехода между текстовыми полями
extension JoinGame: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Разрешаем ввод только цифр и ограничиваем длину ввода одним символом
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) && range.length < 2
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Переход к следующему полю после ввода одной цифры
        if let text = textField.text, text.count == 1 {
            if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // Закрываем клавиатуру, если это последнее поле
            }
        }
    }
}
