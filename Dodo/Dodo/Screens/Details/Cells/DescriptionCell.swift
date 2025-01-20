//
//  DescriptionCell.swift
//  Dodo
//
//  Created by Tia M on 7/5/24.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let reuseID = "DescriptionCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Pizza"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return nameLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Pizza description"
        descriptionLabel.textColor = .gray
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Pizza ingredients"
        ingredientsLabel.font = UIFont.systemFont(ofSize: 20)
        ingredientsLabel.numberOfLines = 0
        return ingredientsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product?) {
        nameLabel.text = product?.name
        ingredientsLabel.text = product?.detail
    }
}

extension DescriptionCell {
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(ingredientsLabel)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    DescriptionCell()
}
