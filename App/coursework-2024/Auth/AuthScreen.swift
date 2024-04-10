import UIKit

final class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let customTransitionDelegate = CustomTransitionAnimator()

    private var titleLabel: UILabel!
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var registerButton: UIButton!
    private var icon: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureTitle()
        configureIcon()
        configureLogin()
        configurePass()
        configureLoginButton()
        configureRegButton()
    }
    
    private func configureTitle() {
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "Agree"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureLogin() {
        loginTextField = UITextField()
        loginTextField.placeholder = "Логин"
        loginTextField.borderStyle = .roundedRect
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.backgroundColor = UIColor(hex: 0x292830)
        loginTextField.textColor = .white
        
        view.addSubview(loginTextField)
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 50),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePass() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = UIColor(hex: 0x292830)
        passwordTextField.textColor = .white
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(hex: 0x007AFF) // Синяя кнопка
        loginButton.layer.cornerRadius = 10 // Скругленные углы
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.masksToBounds = false
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureRegButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor(hex: 0xFF2D55) // Красная кнопка
        registerButton.layer.cornerRadius = 10 // Скругленные углы
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        registerButton.layer.shadowRadius = 4
        registerButton.layer.shadowOpacity = 0.2
        registerButton.layer.masksToBounds = false
        
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureIcon() {
        icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "Image")
        
        view.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            icon.widthAnchor.constraint(equalToConstant: 250), // Ширина изображения
            icon.heightAnchor.constraint(equalToConstant: 300) // Высота изображения
        ])
    }
    
    private func highlightTextField(_ textField: UITextField, message: String) {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        
        // Показываем уведомление о пустом поле
        showAlert(title: "Ошибка", message: message)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    private func loginButtonTapped() {
        guard let username = loginTextField.text, !username.isEmpty else {
            highlightTextField(loginTextField, message: "Пожалуйста, введите логин")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            highlightTextField(passwordTextField, message: "Пожалуйста, введите пароль")
            return
        }
        
//        showAlert(title: "Announce", message: "it works")
        
        if let loginRequest = loginUser(username: username, password: password) {
            URLSession.shared.dataTask(with: loginRequest) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    // Обработка ошибки
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    // Обработка отсутствия данных
                    return
                }
                
                // Обработка ответа от сервера
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    // Показать alert с результатом авторизации
                    DispatchQueue.main.async {
                        if responseString == "Неверный пароль" {
                            self.highlightTextField(self.passwordTextField, message: responseString)
                        }
                        else if responseString == "Пользователя с таким именем не существует" {
                            self.highlightTextField(self.loginTextField, message: responseString)
                        }
                        else if responseString == "Авторизация прошла успешно" {
//                            self.showAlert(title: "Уведомление", message: "Вы успешно вошли в приложение")
                            CurrentUser.shared.username = username;
                            
                            let successViewController = SuccessViewController()
                            successViewController.modalPresentationStyle = .overFullScreen
                            successViewController.transitioningDelegate = self
                            self.present(successViewController, animated: true, completion: nil)
                        }
                    }
                }
                
            }.resume()
        } else {
            print("Failed to create login request")
            // Обработка ошибки создания запроса
        }
    }
    
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransitionDelegate
    }

    
    @objc
    private func registerButtonTapped() {
        guard let username = loginTextField.text, !username.isEmpty else {
            highlightTextField(loginTextField, message: "Пожалуйста, введите логин")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            highlightTextField(passwordTextField, message: "Пожалуйста, введите пароль")
            return
        }
    
        if let registerRequest = registerUser(username: username, password: password) {
            URLSession.shared.dataTask(with: registerRequest) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    // Обработка ошибки
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    // Обработка отсутствия данных
                    return
                }
                
                // Обработка ответа от сервера
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    // Показать alert с результатом авторизации
                    DispatchQueue.main.async {
                        if responseString == "Пользователь с таким именем уже существует" {
                            self.highlightTextField(self.loginTextField, message: responseString)
                        }
                        else if responseString == "Пользователь зарегистрирован успешно" {
//                            self.showAlert(title: "Уведомление", message: "Вы успешно вошли в приложение")
                            CurrentUser.shared.username = username;
                            
                            let successViewController = SuccessViewController()
                            successViewController.modalPresentationStyle = .overFullScreen
                            self.present(successViewController, animated: true, completion: nil)
                        }
                    }
                }
                
            }.resume()
        } else {
            print("Failed to create login request")
            // Обработка ошибки создания запроса
        }
    }
}

final class SuccessViewController: UIViewController {
    
    private var successLabel: UILabel!
    private var mainButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        if let fillRequest = fillInfo(username: CurrentUser.shared.username!) {
            URLSession.shared.dataTask(with: fillRequest) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    // Обработка ошибки
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    // Обработка отсутствия данных
                    return
                }
                
                // Обработка ответа от сервера
                if let decodedUser = try? JSONDecoder().decode(UserNew.self, from: data) {
                    DispatchQueue.main.async {
                        CurrentUser.shared.id = decodedUser.id
                        CurrentUser.shared.name = decodedUser.name
                        CurrentUser.shared.info = decodedUser.info
//                        print(decodedUser)
                        
                        self.configureLabel()
                        self.configureButton()
                    }
                } else {
                    print("Failed to decode JSON")
                }
            }.resume()
        } else {
            print("Failed to create login request")
            // Обработка ошибки создания запроса
        }
        
//        configureLabel()
//        configureButton()
//        animateWelcomeLabel()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        animateWelcomeLabel()
//    }
//    
    private func configureLabel() {
        successLabel = UILabel()
        successLabel.textAlignment = .center
        successLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        successLabel.numberOfLines = 0
//        print(CurrentUser.shared.username!)
//        print(CurrentUser.shared.name!)
//        print(CurrentUser.shared.info!)
        if let name = CurrentUser.shared.name {
            successLabel.text = "Добро пожаловать, \(name)!"
        } else {
            successLabel.text = "Добро пожаловать!"
        }
        successLabel.alpha = 0 // начнем с прозрачного состояния
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        successLabel.textColor = .white
        successLabel.shadowColor = .gray
        successLabel.tintColor = .lightText
        
        view.addSubview(successLabel)
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            successLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            successLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            successLabel.bottomAnchor.constraint(lessThanOrEqualTo: mainButton.topAnchor, constant: -20)
        ])
        
        animateWelcomeLabel()
    }
    
    private func configureButton() {
        mainButton = UIButton(type: .system)
        mainButton.setTitle("Продолжить", for: .normal)
        mainButton.backgroundColor = UIColor(hex: 0x007AFF)
        mainButton.setTitleColor(.white, for: .normal)
        mainButton.layer.cornerRadius = 25
        mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
//        mainButton.alpha = 0
        
        view.addSubview(mainButton)
        NSLayoutConstraint.activate([
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 50),
            mainButton.widthAnchor.constraint(equalToConstant: 200),
            mainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        animateButton()
    }
    
    private func animateWelcomeLabel() {
        UIView.animate(withDuration: 2, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.successLabel.alpha = 1.0
        }, completion: nil)
    }

    private func animateButton() {
        // Анимация кнопки
        mainButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.mainButton.transform = .identity
        }, completion: nil)
    }
    
    @objc
    private func mainButtonTapped() {
        // Действия при нажатии на кнопку перехода на главный экран
        let vc = TabBarController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}


