import UIKit

class FriendsTab: UIViewController {
    
    private var tableView: UITableView!
    private var icon: UIImageView!
    private var friendNames = ["Алексей", "Борис", "Владимир", "Георгий", "Дмитрий", "Евгений", "Жанна", "Зоя", "Игорь", "Кирилл"]
    
    private var friendsHeaderView: UIView!
    private var friendsTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: 0x24232A)
        
        configureHeader()
        configureTitle()
        configureIcon()
        configureTableView()
    }
    
    private func configureHeader() {
        friendsHeaderView = UIView()
        friendsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(friendsHeaderView)
        NSLayoutConstraint.activate([
            friendsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            friendsHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsHeaderView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    private func configureTitle() {
        friendsTitleLabel = UILabel()
        friendsTitleLabel.text = "Друзья"
        friendsTitleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        friendsTitleLabel.textColor = .white
        friendsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(friendsTitleLabel)
        NSLayoutConstraint.activate([
            friendsTitleLabel.leadingAnchor.constraint(equalTo: friendsHeaderView.leadingAnchor, constant: 20),
            friendsTitleLabel.bottomAnchor.constraint(equalTo: friendsHeaderView.bottomAnchor),
        ])
    }
    
    private func configureIcon() {
        icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "Image")

        view.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.trailingAnchor.constraint(equalTo: friendsHeaderView.trailingAnchor, constant: -20),
            icon.centerYAnchor.constraint(equalTo: friendsTitleLabel.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 50), // Ширина изображения
            icon.heightAnchor.constraint(equalToConstant: 60) // Высота изображения
        ])
    }
    
    private func configureTableView() {
//        tableView = UITableView(frame: .zero, style: .plain)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
        tableView.backgroundColor = UIColor(hex: 0x24232A)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: friendsHeaderView.bottomAnchor, constant: 70),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FriendsTab: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nicknameLabel.text = friendNames[indexPath.row]
        cell.inviteButton.addTarget(self, action: #selector(inviteFriend), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteFriend), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func inviteFriend() {
        // Действия для приглашения друга
    }
    
    @objc private func deleteFriend() {
        // Действия для удаления друга
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Высота ячейки
    }
}

class FriendTableViewCell: UITableViewCell {
    static let identifier = "FriendTableViewCell"
    
    let nicknameLabel = UILabel()
    let inviteButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(inviteButton)
        contentView.addSubview(deleteButton)
        
        // Настройка внешнего вида ячейки
        backgroundColor = UIColor(hex: 0x292830) // заданный цвет для ячейки
        
        nicknameLabel.textColor = .white
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        inviteButton.setTitle("Позвать", for: .normal)
        inviteButton.backgroundColor = UIColor(hex: 0x0281e8)
        inviteButton.setTitleColor(.white, for: .normal)
        inviteButton.layer.cornerRadius = 15
        inviteButton.layer.masksToBounds = true
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.backgroundColor = UIColor(hex: 0x8B0000)   
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.layer.cornerRadius = 15
        deleteButton.layer.masksToBounds = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nicknameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            inviteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            inviteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            inviteButton.widthAnchor.constraint(equalToConstant: 80),
            
            deleteButton.trailingAnchor.constraint(equalTo: inviteButton.leadingAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
