//
//  StoriesCell.swift
//  Dodo
//
//  Created by Tia M on 10/6/24.
//

import UIKit

final class StoriesCell: UICollectionViewCell {
    static let reuseID = "StoriesCell"
    
    private var containerView: UIView = {
        $0.backgroundColor = .white
//        $0.applyShadow(cornerRadius: 20)
        return $0
    }(UIView())
    
    private var storyImageView: UIImageView = {
        $0.image = UIImage(named: "default")
        $0.contentMode = .scaleAspectFit
//        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
//        $0.heightAnchor.constraint(equalToConstant: width).isActive = true
//        $0.widthAnchor.constraint(equalToConstant: height).isActive = true
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension StoriesCell {
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(storyImageView)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            storyImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            storyImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            storyImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            storyImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    StoriesCell()
}

