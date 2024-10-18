//
//  AddressCell.swift
//  Dodo
//
//  Created by Tia M on 10/18/24.
//

import UIKit

final class AddressCell: UITableViewCell {
    static let reuseID = "AddressCell"
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "addressLabel"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let editButton: UIButton = {
        let editButton = UIButton()
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .darkGray
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
    
    @objc func editButtonTapped(_ sender: UIButton) {
        
    }
}

extension AddressCell {
    private func setupViews() {
        
        contentView.addSubview(horizontalStackView)
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
