//
//  IngredientsCell.swift
//  Dodo
//
//  Created by Tia M on 7/6/24.
//

import UIKit

class IngredientsContainerCell: UITableViewCell {
    static let reuseID = "IngredientsCell"
    
    var product: Product? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemCount: CGFloat = 3
        let padding:CGFloat = 20
        let paddingCount = itemCount + 1
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        let paddingSize = paddingCount * padding
        let cellSize = (UIScreen.main.bounds.width - paddingSize) / itemCount
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: cellSize, height: cellSize * 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IngredientCollectionCell.self, forCellWithReuseIdentifier: IngredientCollectionCell.reuseID)
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
    
    func update(_ product: Product?) {
        self.product = product
    }
    
}

//MARK: - Layout
extension IngredientsContainerCell {
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
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension IngredientsContainerCell: UICollectionViewDelegate {
}

//MARK: - UICollectionViewDataSource
extension IngredientsContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product?.ingredients?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionCell.reuseID, for: indexPath) as? IngredientCollectionCell else {
            return UICollectionViewCell()
        }
        
        if let ingredient = product?.ingredients?[indexPath.row] {
            cell.update(ingredient)
        }
        
        cell.backgroundColor = .yellow
        return cell
    }
}

#Preview(traits: .portrait) {
    IngredientsContainerCell()
}
