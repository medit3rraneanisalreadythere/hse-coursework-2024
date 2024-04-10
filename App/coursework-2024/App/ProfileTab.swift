import UIKit

class ProfileTab: UIViewController {
    private var profileHeaderView: UIView!
    private var profileTitleLabel: UILabel!
    private var editButton: UIButton!
    private var avatarImageView: UIImageView!
    private var tableView: UITableView!
    private var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: 0x24232A)
        configureUI()
    }
    
    private func configureUI() {
        configureHeader()
        configureTitle()
        configureButton()
        configureImage()
        configureTable()
        configureIcon()
    }
    
    private func configureHeader() {
        profileHeaderView = UIView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileHeaderView)
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    private func configureTitle() {
        profileTitleLabel = UILabel()
        profileTitleLabel.text = "Профиль"
        profileTitleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        profileTitleLabel.textColor = .white
        profileTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileTitleLabel)
        NSLayoutConstraint.activate([
            profileTitleLabel.leadingAnchor.constraint(equalTo: profileHeaderView.leadingAnchor, constant: 20),
            profileTitleLabel.bottomAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
        ])
    }
    
    private func configureButton() {
        editButton = UIButton(type: .system)
        editButton.setTitle("Изменить", for: .normal)
        editButton.backgroundColor = UIColor(hex: 0x0281e8)
        editButton.setTitleColor(.white, for: .normal)
        editButton.layer.cornerRadius = 8
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: profileHeaderView.trailingAnchor, constant: -20),
            editButton.centerYAnchor.constraint(equalTo: profileTitleLabel.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 90),
            editButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func configureImage() {
        avatarImageView = UIImageView()
//        avatarImageView.image = UIImage(systemName: "person.circle")
        avatarImageView.image = UIImage(named: "Avatar")
//        avatarImageView.tintColor = .gray
        avatarImageView.contentMode = .scaleAspectFill
//        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.layer.cornerRadius = 50 // половина размера высоты, если высота равна 100
        avatarImageView.layer.borderWidth = 2 // ширина обводки
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.clipsToBounds = true
        
        view.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 70),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
    private func configureTable() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "profileCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureIcon() {
        icon = UIImageView()
        icon.image = UIImage(named: "Image")
//        icon.contentMode = .scaleAspectFit // Или .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(icon)

//        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // Отступ от tabBar
            icon.heightAnchor.constraint(equalToConstant: 90),
            icon.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}

// Продолжение класса ProfileTab


// Методы UITableViewDelegate и UITableViewDataSource

extension ProfileTab: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // Три секции для никнейма, имени, о себе
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Одна ячейка в каждой секции
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0
//        cell.backgroundColor = UIColor(white: 0.18, alpha: 1)
        cell.backgroundColor = UIColor(hex: 0x292830)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = CurrentUser.shared.username
        case 1:
            cell.textLabel?.text = CurrentUser.shared.name
        case 2:
            cell.textLabel?.text = CurrentUser.shared.info
        default:
            cell.textLabel?.text = "Неизвестный раздел"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2: // Индекс секции "О себе"
            return UITableView.automaticDimension
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2: // Индекс секции "О себе"
            return 100
        default:
            return 44
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5 // Высота для header
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor // Цвет фона отступа

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)

        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])

        switch section {
        case 0:
            titleLabel.text = "Никнейм"
        case 1:
            titleLabel.text = "Имя"
        case 2:
            titleLabel.text = "О себе"
        default:
            break
        }

        return headerView
    }
    

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 // Высота для footer, которая будет действовать как отступ между секциями
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}

