//
//  StoriesContainerCell.swift
//  Dodo
//
//  Created by Tia M on 9/29/24.
//

import UIKit

final class StoriesContainerCell: UITableViewCell {
    static let reuseID = "StoriesContainerCell"
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var stories: [Story] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var onStoriesCellSelected: ((IndexPath)->())?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoriesCollectionCell.self, forCellWithReuseIdentifier: StoriesCollectionCell.reuseID)
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
    
    func update(_ stories: [Story]) {
        self.stories = stories
    }

}

//MARK: - Layout
extension StoriesContainerCell {
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
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension StoriesContainerCell: UICollectionViewDelegate {
}

//MARK: - UICollectionViewDataSource
extension StoriesContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionCell.reuseID, for: indexPath) as? StoriesCollectionCell else {
            return UICollectionViewCell()
        }
        let story = stories[indexPath.item]
//        cell.update(story, imageCache: imageCache)
        cell.update(story)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let story = stories[indexPath.item]
        //let storiesVC = StoriesScreenVC()
        //storiesVC.update(stories, startingAt: indexPath.item, imageCache: imageCache)
        onStoriesCellSelected?(indexPath)
    }
}

