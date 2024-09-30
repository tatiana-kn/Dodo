//
//  AddressView.swift
//  Dodo
//
//  Created by Tia M on 9/30/24.
//

import UIKit

final class AddressView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let addressLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Address"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        nameLabel.textAlignment = .left
        return nameLabel
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
}

extension AddressView {
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(imageView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    AddressView()
}
