//
//  AddressView.swift
//  Dodo
//
//  Created by Tia M on 9/30/24.
//

import UIKit

final class AddressView: UIView {
    var onAdressButtonTapped: (() -> ())?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let addressButton: UIButton = {
        let addressButton = UIButton()
        addressButton.setTitle("Address", for: .normal)
        addressButton.setTitleColor(.black, for: .normal)
        addressButton.addTarget(nil, action: #selector(adressButtonTapped), for: .touchUpInside)
        
//        addressButton.text = "Address"
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return addressButton
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
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

extension AddressView {
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(addressButton)
        stackView.addArrangedSubview(imageView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addressButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addressButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            addressButton.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor),
            addressButton.topAnchor.constraint(greaterThanOrEqualTo: stackView.topAnchor),
            addressButton.bottomAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor)
//            imageView.topAnchor.constraint(lessThanOrEqualTo: stackView.topAnchor),
//            imageView.bottomAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    AddressView()
}
