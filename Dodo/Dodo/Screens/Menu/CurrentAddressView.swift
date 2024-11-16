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
        addressButton.titleLabel?.numberOfLines = 0
        addressButton.titleLabel?.textAlignment = .left
        addressButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addressButton.setAttributedTitle(NSAttributedString(string: "address"), for: .normal)
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
    
    func updateAddressButton(address: String, deliveryTime: String) {
        let fullText = "\(address)\n\(deliveryTime)"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: address.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: address.count))
        
        let deliveryRange = NSRange(location: address.count + 1, length: deliveryTime.count)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: deliveryRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: deliveryRange)
        
        addressButton.setAttributedTitle(attributedText, for: .normal)
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
