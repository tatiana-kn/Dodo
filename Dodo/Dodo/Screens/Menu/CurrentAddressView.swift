//
//  AddressView.swift
//  Dodo
//
//  Created by Tia M on 9/30/24.
//

import UIKit

final class CurrentAddressView: UIView {
    var onAdressButtonTapped: (() -> ())?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
//        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    var addressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "figure.walk.circle")
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private let addressButton: UIButton = {
        let addressButton = UIButton()
        addressButton.setTitle("Address", for: .normal)
        addressButton.setTitleColor(.black, for: .normal)
        addressButton.addTarget(nil, action: #selector(adressButtonTapped), for: .touchUpInside)
        return addressButton
    }()
    
    var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private let spacerView: UIView = {
        let spacerView = UIView()
        return spacerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func adressButtonTapped(_ sender: UIButton) {
        onAdressButtonTapped?()
    }
    
}

extension CurrentAddressView {
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(addressImageView)
        stackView.addArrangedSubview(addressButton)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(accountImageView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addressButton.translatesAutoresizingMaskIntoConstraints = false
        accountImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    CurrentAddressView()
}
