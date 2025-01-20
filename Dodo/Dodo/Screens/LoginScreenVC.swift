//
//  LoginScreenVC.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import UIKit

class LoginScreenVC: UIViewController  {

    var onUserLogged: ((Bool)->())?
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    
    @objc func loginAction(_ sender: Any) {
        let userIsLogged = true
        onUserLogged?(userIsLogged)
    }
}

extension LoginScreenVC {
    private func setupViews() {
        view.addSubview(loginButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
