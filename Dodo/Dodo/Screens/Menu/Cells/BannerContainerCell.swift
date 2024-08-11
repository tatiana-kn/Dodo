//
//  BanerContainerCell.swift
//  Dodo
//
//  Created by Tia M on 8/9/24.
//

import UIKit

final class BannerContainerCell: UITableViewCell {
    static let reuseID = "BannerContainerCell"
    
    var products: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
//        let itemCount: CGFloat = 3
//        let padding:CGFloat = 20
//        let paddingCount = itemCount + 1
        
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = padding
//        layout.minimumInteritemSpacing = padding
        
//        let paddingSize = paddingCount * padding
//        let cellSize = (UIScreen.main.bounds.width - paddingSize) / itemCount
//        
//        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        layout.itemSize = CGSize(width: 200, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ products: [Product]) {
        self.products = products
    }

}

//MARK: - Layout
extension BannerContainerCell {
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension BannerContainerCell: UICollectionViewDelegate {
}

//MARK: - UICollectionViewDataSource
extension BannerContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseID, for: indexPath) as? BannerCollectionCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]

        cell.update(product)
        
        cell.backgroundColor = .yellow
        return cell
    }
}

