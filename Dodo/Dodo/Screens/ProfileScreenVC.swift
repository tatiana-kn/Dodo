//
//  ProfileScreenVC.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import UIKit

class ProfileScreenVC: UIViewController {

    var onLogout: ((Bool)->())?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    @objc func logoutAction(_ sender: Any) {
        
        self.onLogout?(true)
    }
    
}

extension ProfileScreenVC {
    private func setupViews() {
        view.addSubview(logoutButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

