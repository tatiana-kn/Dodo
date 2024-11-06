//
//  DetailScreenVC.swift
//  Dodo
//
//  Created by Tia M on 7/5/24.
//

import UIKit

final class DetailScreenVC: UIViewController {
    
    var ingredientLoader: IIngredientsLoader
    var ingredients: [Ingredient] = []
    var product: Product?
    var productsRepository: IProductsRepository
        
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
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить за", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        return button
    }()
    
//    init(product: Product) {
//        self.product = product
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    init(_ ingredientsLoader: IIngredientsLoader, _ productsRepository: IProductsRepository) {
        self.ingredientLoader = ingredientsLoader
        self.productsRepository = productsRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        self.product = product
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        loadIngredients()
    }
    
    @objc private func addToCart(_ sender: UIButton) {
        guard let product else { return }
        
        productsRepository.add(product)
        
        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil) // ???
        
        dismiss(animated: true, completion: nil)
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
//            cell.update(product)
            cell.update(ingredients)
            
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

extension DetailScreenVC {
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(orderButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor),
            
            orderButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 25),
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

//#Preview(traits: .portrait) {
////    DetailScreenVC()
//}

