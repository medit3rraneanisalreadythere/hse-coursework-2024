//
//  API.swift
//  coursework-2024
//
//  Created by Таня Белка on 06.04.2024.
//

import Foundation
import UIKit

struct User: Codable {
    let username: String
    let password: String
}

struct Username: Codable {
    let username: String
}

struct UserNew: Codable {
    var id: Int
    var username: String
    var name: String?
    var info: String?
    
    // Enum для ключей JSON, если они отличаются от названий свойств структуры
    private enum CodingKeys: String, CodingKey {
        case id, username, name, info
    }
}

class CurrentUser {
    static let shared = CurrentUser()
    
    var id: Int?
    var username: String?
    var name: String?
    var info: String?
//    var avatarImage: UIImage?
    // другие необходимые свойства
    
    private init() {}
}



func registerUser(username: String, password: String) -> URLRequest? {
    let user = User(username: username, password: password)
    guard let url = URL(string: "http://localhost:8080/api/register") else {
        print("Invalid URL")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(user)
        request.httpBody = jsonData
        return request
    } catch {
        print("Error encoding user data: \(error.localizedDescription)")
        return nil
    }
}

func loginUser(username: String, password: String) -> URLRequest? {
    let user = User(username: username, password: password)
    guard let url = URL(string: "http://localhost:8080/api/login") else {
        print("Invalid URL")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(user)
        request.httpBody = jsonData
        return request
    } catch {
        print("Error encoding user data: \(error.localizedDescription)")
        return nil
    }
}

func fillInfo(username: String) -> URLRequest? {
    let username = Username(username: username)
    guard let url = URL(string: "http://localhost:8080/api/getinfo") else {
        print("Invalid URL")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(username)
        request.httpBody = jsonData
        return request
    } catch {
        print("Error encoding user data: \(error.localizedDescription)")
        return nil
    }
}



class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.8

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)

        // Начальное состояние
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        // Анимация
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

