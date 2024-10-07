//
//  StoriesCollectionCell.swift
//  Dodo
//
//  Created by Tia M on 9/29/24.
//

import UIKit
import SDWebImage

final class StoriesCollectionCell: UICollectionViewCell {
    static let reuseID = "StoriesCollectionCell"

    private var containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 20)
        return $0
    }(UIView())
    
    private var storyImageView: UIImageView = {
        $0.image = UIImage(named: "default")
        $0.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        $0.heightAnchor.constraint(equalToConstant: 0.2 * width).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 0.2 * width).isActive = true
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
    
    func update(_ story: Story) {
        
        let url = URL.init(string: story.path)
        storyImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default"))
    }
}

//MARK: - Layout
extension StoriesCollectionCell {
    
    struct Layout {
        static let offset: CGFloat = 4
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(storyImageView)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset * 2),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset * 2),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.offset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.offset)
        ])
        
        NSLayoutConstraint.activate([
            storyImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            storyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    StoriesCollectionCell()
}


