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
        
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Pizza"
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        return nameLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Pizza description"
        return descriptionLabel
    }()
    
    private let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Pizza ingredients"
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
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
