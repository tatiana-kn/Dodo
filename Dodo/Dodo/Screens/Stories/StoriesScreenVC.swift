//
//  StoriesScreenVC.swift
//  Dodo
//
//  Created by Tia M on 10/6/24.
//

import UIKit

final class StoriesScreenVC: UIViewController {
    var stories: [Story] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.horizontalScrollIndicatorInsets.bottom = 10
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: StoriesCell.reuseID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func update(_ stories: [Story], _ indexPath: IndexPath) {
        self.stories = stories
        collectionView.performBatchUpdates({
            collectionView.reloadData()
        }, completion: { _ in
            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        })
    }
}

//MARK: - UICollectionViewDelegate
extension StoriesScreenVC: UICollectionViewDelegate {
}

//MARK: - UICollectionViewDataSource
extension StoriesScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCell.reuseID, for: indexPath) as? StoriesCell else {
            return UICollectionViewCell()
        }
        let story = stories[indexPath.item]
        cell.update(story)
        return cell
    }
}

//MARK: - Layout
extension StoriesScreenVC {
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


#Preview(traits: .portrait) {
    StoriesScreenVC()
}
