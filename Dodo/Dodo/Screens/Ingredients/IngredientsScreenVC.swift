//
//  IngredientsScreenVC.swift
//  Dodo
//
//  Created by Tia M on 7/4/24.
//

import UIKit

//class IngredientsScreenVC: UIViewController {
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let itemCount: CGFloat = 3
//        let padding:CGFloat = 20
//        let paddingCount = itemCount + 1
//        
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = padding
//        layout.minimumInteritemSpacing = padding
//        
//        let paddingSize = paddingCount * padding
//        let cellSize = (UIScreen.main.bounds.width - paddingSize) / itemCount
//        
//        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        //        layout.itemSize = CGSize(width: cellSize, height: cellSize)
//        layout.itemSize = CGSize(width: cellSize, height: cellSize * 2)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .orange
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseID)
//        
//        return collectionView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupViews()
//        setupConstraints()
//    }
//}
//
////MARK: - Layout
//extension IngredientsScreenVC {
//    private func setupViews() {
//        view.addSubview(collectionView)
//    }
//    
//    private func setupConstraints() {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let safeArea = view.safeAreaLayoutGuide
//        
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
//            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
//            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
//            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
//        ])
//    }
//}
//
////MARK: - UICollectionViewDelegate
//extension IngredientsScreenVC: UICollectionViewDelegate {
//}
//
////MARK: - UICollectionViewDataSource
//extension IngredientsScreenVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.reuseID, for: indexPath)
//        cell.backgroundColor = .yellow
//        return cell
//    }
//}
//
//#Preview(traits: .portrait) {
//    IngredientsScreenVC()
//}
