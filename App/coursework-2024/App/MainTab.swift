//
//  MainScreen.swift
//  coursework-2024
//
//  Created by Таня Белка on 08.04.2024.
//

import UIKit

final class MainTab: UIViewController {
    private var icon: UIImageView!
    private var testLabel: UILabel!
    private var gameStartButton: UIButton!
    private var modeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureIcon()
        configureButton()
        configureSwitcher()
    }
    
    private func configureIcon() {
        icon = UIImageView()
        icon.image = UIImage(named: "Image")
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 120), // Укажите нужную высоту изображения
            icon.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureButton() {
        gameStartButton = UIButton(type: .custom)
//        if let buttonImage = UIImage(named: "gameButtonImage") {
//            gameStartButton.setBackgroundImage(buttonImage, for: .normal)
//        }
        
        gameStartButton.setBackgroundImage(UIImage(systemName: "bonjour"), for: .normal)
        
        gameStartButton.setTitle("Играть", for: .normal)
        gameStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        gameStartButton.contentHorizontalAlignment = .center
//        gameStartButton.contentVerticalAlignment = .center
        gameStartButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: 0, right: 0) // Отрегулируйте по нуждам
        gameStartButton.addTarget(self, action: #selector(gameStartButtonTapped(_:)), for: .touchUpInside)
        
        gameStartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameStartButton)
        
        // Констрейнты для кнопки
        NSLayoutConstraint.activate([
            gameStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameStartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameStartButton.widthAnchor.constraint(equalToConstant: 300),
            gameStartButton.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureSwitcher() {
        modeSegmentedControl = UISegmentedControl(items: ["Создать игру", "Присоединиться к игре"])
        modeSegmentedControl.selectedSegmentIndex = 0
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        modeSegmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        modeSegmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        modeSegmentedControl.addTarget(self, action: #selector(modeChanged), for: .valueChanged)
        modeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(modeSegmentedControl)
        NSLayoutConstraint.activate([
            modeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modeSegmentedControl.bottomAnchor.constraint(equalTo: gameStartButton.topAnchor, constant: -10)
        ])
    }
    
    @objc private func gameStartButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            // Отскок обратно к начальному состоянию с "перекидыванием" через масштаб 1.1
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 3,
                           options: .allowUserInteraction,
                           animations: {
                sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { _ in
                // Возвращаемся к исходному масштабу
                UIView.animate(withDuration: 0.1) {
                    sender.transform = CGAffineTransform.identity
                }
            }
        }
        
        let selectedIndex = modeSegmentedControl.selectedSegmentIndex
        switch selectedIndex {
            case 0:
                // Переход к экрану создания игры
                let vc = CreateGame()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            
                print("Создать игру")
            case 1:
                // Переход к экрану присоединения к игре
                let vc = JoinGame()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            
                print("Присоединиться к игре")
            default:
                break
        }
    }
    
    @objc private func modeChanged() {
        // Обработка изменения режима игры 
        print("Режим изменён: \(modeSegmentedControl.selectedSegmentIndex)")
    }
}
