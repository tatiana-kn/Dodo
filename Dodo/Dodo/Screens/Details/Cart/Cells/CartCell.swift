//
//  CartCell.swift
//  Dodo
//
//  Created by Tia M on 8/21/24.
//

import UIKit

final class CartCell: UITableViewCell {
    static let reuseID = "CartCell"
    
    private var cardStackView: UIStackView = {
        $0.axis = .vertical
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIStackView())
    
    private var containerView: UIView = {
        $0.backgroundColor = .white
//        $0.applyShadow(cornerRadius: 10)
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
    
    private var horizontalStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 25
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    private var priceLabel: UILabel = {
        $0.text = "от 469 руб"
        return $0
    }(UILabel())
    
    private var productImageView: UIImageView = {
        $0.image = UIImage(named: "default")
        $0.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        $0.heightAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var stepper = CustomStepper()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        setupStepper()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailedLabel.text = product.detail
        priceLabel.text = "\(product.price) р"
        productImageView.image = UIImage(named: product.image) ?? UIImage(named: "default")
    }
    
}


extension CartCell {
    
    struct Layout {
        static let offset: CGFloat = 8
    }
    
    private func setupViews() {
//        [containerView].forEach {
//            contentView.addSubview($0)
//        }
        
        [cardStackView].forEach {
            contentView.addSubview($0)
        }
        
        [containerView, horizontalStackView].forEach {
            cardStackView.addSubview($0)
        }
        
        [productImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, detailedLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [priceLabel, stepper].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset * 2),
            cardStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset * 2),
            cardStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.offset),
            cardStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.offset)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: cardStackView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: cardStackView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: cardStackView.topAnchor)
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
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: cardStackView.leadingAnchor, constant: Layout.offset),
            horizontalStackView.trailingAnchor.constraint(equalTo: cardStackView.trailingAnchor, constant: -Layout.offset),
            horizontalStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Layout.offset),
            horizontalStackView.bottomAnchor.constraint(equalTo: cardStackView.bottomAnchor, constant: -Layout.offset)
        ])
        
        NSLayoutConstraint.activate([
            stepper.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupStepper() {
        stepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
    }
    
    @objc private func stepperChangedValueAction(sender: CustomStepper) {
        print(sender)
        print(sender.currentValue)
    }
}

#Preview(traits: .portrait) {
    CartCell()
}
