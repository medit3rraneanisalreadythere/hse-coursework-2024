import UIKit

final class WaitingForGame: UIViewController {
    private var waitingLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x24232A)
        configureUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.navigateToNextScreen()
        }
    }
    
    private func navigateToNextScreen() {
        let vc = Game()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func configureUI() {
        configureWaitingLabel()
        configureActivityIndicator()
    }
    
    private func configureWaitingLabel() {
        waitingLabel = UILabel()
        waitingLabel.text = "Ожидание начала игры..."
        waitingLabel.textColor = .white
        waitingLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        waitingLabel.textAlignment = .center
        waitingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(waitingLabel)
        NSLayoutConstraint.activate([
            waitingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waitingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: waitingLabel.bottomAnchor, constant: 20)
        ])
    }
}
