//
//  DetailScreenVC.swift
//  Dodo
//
//  Created by Tia M on 7/5/24.
//

import UIKit

final class DetailScreenVC: UIViewController {
    
    var ingredientLoader = IngredientsLoader()
    var ingredients: [Ingredient]?
    var product: Product?
//    {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DetailPhotoCell.self, forCellReuseIdentifier: DetailPhotoCell.reuseID)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseID)
        tableView.register(ControlsCell.self, forCellReuseIdentifier: ControlsCell.reuseID)
        tableView.register(IngredientsContainerCell.self, forCellReuseIdentifier: IngredientsContainerCell.reuseID)
        
        return tableView
    }()
    
//    init(product: Product) {
//        self.product = product
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func update(_ product: Product) {
        self.product = product
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        loadIngredients()
    }
}

extension DetailScreenVC {
    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension DetailScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPhotoCell.reuseID, for: indexPath) as? DetailPhotoCell else {
                return UITableViewCell()
            }
            
            cell.update(product)
            
            return cell
        }
        
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseID, for: indexPath) as? DescriptionCell else {
                return UITableViewCell()
            }
            
            cell.update(product)
            return cell
        }
        
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ControlsCell.reuseID, for: indexPath) as? ControlsCell else {
                return UITableViewCell()
            }
            return cell
        }
        
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsContainerCell.reuseID, for: indexPath) as? IngredientsContainerCell else {
                return UITableViewCell()
            }
            
            cell.update(product)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension DetailScreenVC {
    private func loadIngredients() {
        ingredientLoader.loadIngredients { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let ingredients):
                DispatchQueue.main.async {
                    self.ingredients = ingredients
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview(traits: .portrait) {
    DetailScreenVC()
}

