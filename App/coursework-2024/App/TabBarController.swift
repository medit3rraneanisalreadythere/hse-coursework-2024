import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

func demo() {
    CurrentUser.shared.id = 1
    
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor(hex: 0x0281e8)
        
        // Создание экранов (контроллеров) для вкладок
        let homeVC = MainTab()
        let profileVC = ProfileTab()
        let friendsVC = FriendsTab()
        
        // Установка заголовков и изображений для вкладок
        homeVC.tabBarItem = UITabBarItem(title: "Игра", image: UIImage(systemName: "house"), tag: 0)
        friendsVC.tabBarItem = UITabBarItem(title: "Друзья", image: UIImage(systemName: "person.3.sequence.fill"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)
        
        // Установка контроллеров в таббар
        viewControllers = [homeVC, friendsVC, profileVC]
        
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.red, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineHeight: 2.0)
        
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
            item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        }
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineHeight, width: size.width, height: lineHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
