//
//  ProductCell.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static let reuseID = "ProductCell"
    
    private var containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .leading
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private var nameLabel: UILabel = {
        $0.text = "Пепперони"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private var detailedLabel: UILabel = {
        $0.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    private var priceButton: UIButton = {
        $0.setTitle("от 469 руб", for: .normal)
        $0.backgroundColor = .orange.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 20
        $0.setTitleColor(.brown, for: .normal)
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        $0.configuration = config
        return $0
    }(UIButton())
    
    private var productImageView: UIImageView = {
        $0.image = UIImage(named: "pizza")
        $0.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        $0.heightAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailedLabel.text = product.detail
        priceButton.setTitle("\(product.price) р", for: .normal)
        productImageView.image = UIImage(named: product.image) ?? UIImage(named: "default")
    }
}

//MARK: - Layout
extension ProductCell {
    
    struct Layout {
        static let offset: CGFloat = 8
    }
    
    private func setupViews() {
        [containerView].forEach {
            contentView.addSubview($0)
        }
        
        [productImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, detailedLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset * 2),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset * 2),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.offset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.offset)
        ])
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.offset),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            productImageView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: Layout.offset),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Layout.offset)
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Layout.offset),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.offset),
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.offset),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.offset)
        ])
    }
}

#Preview(traits: .portrait) {
    MenuScreenVC()
}
