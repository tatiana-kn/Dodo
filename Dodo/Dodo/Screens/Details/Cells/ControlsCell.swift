//
//  ControlsCell.swift
//  Dodo
//
//  Created by Tia M on 7/5/24.
//

import UIKit

class ControlsCell: UITableViewCell {
    
    var onDoughChanged: ((DoughType) -> ())?
    var onSizeChanged: ((Size) -> ())?
    
    static let reuseID = "ControlsCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let sizeControls: UISegmentedControl = {
        let controls = UISegmentedControl()
        controls.insertSegment(withTitle: "Маленькая", at: 0, animated: true)
        controls.insertSegment(withTitle: "Средняя", at: 1, animated: true)
        controls.insertSegment(withTitle: "Большая", at: 2, animated: true)
        controls.selectedSegmentIndex = 1
        controls.addTarget(nil, action: #selector(sizeChanged(sender:)), for: .valueChanged)
        
        return controls
    }()
    
    private let doughControls: UISegmentedControl = {
        let controls = UISegmentedControl()
        controls.insertSegment(withTitle: "Традиционное", at: 0, animated: true)
        controls.insertSegment(withTitle: "Тонкое", at: 1, animated: true)
        controls.selectedSegmentIndex = 0
        controls.addTarget(nil, action: #selector(doughTypeChanged(sender:)), for: .valueChanged)
        
        return controls
    }()
    
    @objc private func doughTypeChanged(sender: UISegmentedControl) {
        let selectedDough = DoughType.getDoughType(sender.selectedSegmentIndex)
        onDoughChanged?(selectedDough)
    }
    
    @objc private func sizeChanged(sender: UISegmentedControl) {
        let selectedSize = Size.getSize(sender.selectedSegmentIndex)
        onSizeChanged?(selectedSize)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ControlsCell {
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(sizeControls)
        stackView.addArrangedSubview(doughControls)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        sizeControls.translatesAutoresizingMaskIntoConstraints = false
        doughControls.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sizeControls.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            sizeControls.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            doughControls.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            doughControls.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8)
        ])
    }
}

#Preview(traits: .portrait) {
    ControlsCell()
}
