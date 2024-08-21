//
//  CustomStepper.swift
//  Dodo
//
//  Created by Tia M on 8/21/24.
//

import UIKit

final class CustomStepper: UIControl {
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "\(currentValue)"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
}

extension CustomStepper {
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(decreaseButton)
        horizontalStackView.addArrangedSubview(currentStepValueLabel)
        horizontalStackView.addArrangedSubview(increaseButton)
    }
    
    private func setupContraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
