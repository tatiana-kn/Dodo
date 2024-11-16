//
//  PhotoCollectionCell.swift
//  Dodo
//
//  Created by Tia M on 7/4/24.
//

import UIKit

final class IngredientCollectionCell: UICollectionViewCell {
    
    static let reuseID = "IngredientCollectionCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Маринованные огурчики"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "79р"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ ingredient: Ingredient, isSelected: Bool) {
        nameLabel.text = ingredient.name
        priceLabel.text = String("\(ingredient.price) р.")
        photoImageView.image = UIImage(named: ingredient.image) ?? UIImage(named: "default")
        checkmarkImageView.isHidden = !isSelected
    }
}

//MARK: - Layout
extension IngredientCollectionCell {
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(checkmarkImageView)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            checkmarkImageView.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 8),
            checkmarkImageView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

#Preview(traits: .portrait) {
    IngredientCollectionCell()
}

