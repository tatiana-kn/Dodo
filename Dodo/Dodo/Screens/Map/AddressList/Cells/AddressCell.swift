//
//  AddressCell.swift
//  Dodo
//
//  Created by Tia M on 10/18/24.
//

import UIKit

final class AddressCell: UITableViewCell {
    static let reuseID = "AddressCell"
    
    var onEditButtonTapped: (() -> Void)?
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle") // largecircle.fill.circle
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 23).isActive = true
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "address"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let editButton: UIButton = {
        let editButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let image = UIImage(systemName: "pencil", withConfiguration: largeConfig)
        editButton.setImage(image, for: .normal)
        editButton.tintColor = .gray
        editButton.addTarget(nil, action: #selector(editButtonTapped), for: .touchUpInside)
        return editButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ address: Address, _ isSelected: Bool = false) {
        addressLabel.text = address.name
        selectImageView.image = isSelected ? UIImage(systemName: "largecircle.fill.circle") : UIImage(systemName: "circle")
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        onEditButtonTapped?()
    }
}

extension AddressCell {
    private func setupViews() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(selectImageView)
        horizontalStackView.addArrangedSubview(addressLabel)
        horizontalStackView.addArrangedSubview(editButton)
    }
    
    private func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
