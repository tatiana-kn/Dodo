//
//  PlaceDescriptionView.swift
//  Dodo
//
//  Created by Tia M on 10/20/24.
//

import UIKit
import SnapKit

final class PlaceDescriptionView: UIView {
    
    private var floorLabel: UILabel = {
        let label = UILabel()
        label.text = "Этаж"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var floorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш этаж"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return textField
    }()
    
    private let floorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 16
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private var apartmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Квартира"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var apartmentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваша квартира"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return textField
    }()
    
    private let apartmentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        //stack.spacing = 4
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 16
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Комментарий к адресу"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш комментарий"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return textField
    }()
    
    private let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
//        stack.spacing = 4
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 16
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlaceDescriptionView {
    
    func setupViews() {
        horizontalStackView.addArrangedSubview(floorStackView)
        horizontalStackView.addArrangedSubview(apartmentStackView)
        
        mainStackView.addArrangedSubview(horizontalStackView)
        mainStackView.addArrangedSubview(commentStackView)
        
        self.addSubview(mainStackView)
        
        floorStackView.addArrangedSubview(floorLabel)
        floorStackView.addArrangedSubview(floorTextField)
        
        apartmentStackView.addArrangedSubview(apartmentLabel)
        apartmentStackView.addArrangedSubview(apartmentTextField)
        
        commentStackView.addArrangedSubview(commentLabel)
        commentStackView.addArrangedSubview(commentTextField)
    }
    
    func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}

#Preview(traits: .portrait) {
    PlaceDescriptionView()
}
