//
//  DetailPhotoCell.swift
//  Dodo
//
//  Created by Tia M on 7/5/24.
//

import UIKit

class DetailPhotoCell: UITableViewCell {
    static let reuseID = "DetailPhotoCell"
    
    var detailImageView: UIImageView = {
        let imageView = UIImageView()
        let screenWidth = UIScreen.main.bounds.width
        imageView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: screenWidth).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "default")
        
        return imageView
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
        detailImageView.image = UIImage(named: product?.image ?? "default")
    }
    
}

extension DetailPhotoCell {
    private func setupViews() {
        contentView.addSubview(detailImageView)
    }
    
    private func setupConstraints() {
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            detailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    DetailPhotoCell()
}
