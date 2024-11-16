//
//  AddressListHeaderView.swift
//  Dodo
//
//  Created by Tia M on 10/19/24.
//

import UIKit

final class AddressListHeaderView: UIView {
    var onNewAddressButtonTapped: (() -> ())?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        $0.text = "Мои адреса"
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        return $0
    }(UILabel())
    
    private let newAddressButton: UIButton = {
        let addressButton = UIButton(type: .system)
        
        var config = UIButton.Configuration.filled()
        config.title = "+ Новый адрес"
        config.baseBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        config.baseForegroundColor = .black
        config.background.cornerRadius = 20
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7)
        addressButton.configuration = config
        addressButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addressButton.addTarget(nil, action: #selector(newAddressButtonTapped), for: .touchUpInside)
        return addressButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func newAddressButtonTapped(_ sender: UIButton) {
        onNewAddressButtonTapped?()
    }
}

extension AddressListHeaderView {
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(newAddressButton)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        newAddressButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

