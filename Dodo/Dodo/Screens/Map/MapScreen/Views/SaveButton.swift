//
//  SaveButton.swift
//  Dodo
//
//  Created by Tia M on 10/20/24.
//

import UIKit

final class SaveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCommonInit() {
        self.backgroundColor = .orange
        //self.titleLabel?.text = "Сохранить"
        //self.tintColor = UIColor.white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
//        self.setTitle("Сохранить", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
}
