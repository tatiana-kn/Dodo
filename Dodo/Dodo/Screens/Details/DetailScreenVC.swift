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
    var selectedIngredients: [Ingredient] = []
    var productsRepository: IProductsRepository
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.register(DetailPhotoCell.self, forCellReuseIdentifier: DetailPhotoCell.reuseID)
//        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseID)
//        tableView.register(ControlsCell.self, forCellReuseIdentifier: ControlsCell.reuseID)
//        tableView.register(IngredientsContainerCell.self, forCellReuseIdentifier: IngredientsContainerCell.reuseID)
        tableView.registerCell(DetailPhotoCell.self)
        tableView.registerCell(DescriptionCell.self)
        tableView.registerCell(ControlsCell.self)
        tableView.registerCell(IngredientsContainerCell.self)
        
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
    
    init(ingredientsLoader: IIngredientsLoader, productsRepository: IProductsRepository) {
        self.ingredientLoader = ingredientsLoader
        self.productsRepository = productsRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        self.product = product
        orderButton.setTitle("Оформить за \(String(product.basePrice)) р.", for: .normal)
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
        
        productsRepository.update(product, with: selectedIngredients)
//        productsRepository.add(product)
                
        dismiss(animated: true, completion: nil)
    }
    
    func setPrice() {
        let multiplier = Size.getPriceMultiplier(for: product?.size ?? Size.medium)
        let price = Int(Double(product?.basePrice ?? 1) * multiplier)
        let ingredientsPrice = selectedIngredients.compactMap { $0.price }.reduce(0, +)
        product?.calculatedPrice = price + ingredientsPrice
        
        orderButton.setTitle("Оформить за \(String(product?.calculatedPrice ?? 0)) р.", for: .normal)
    }
}

extension DetailScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product?.type == "пицца" ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPhotoCell.reuseID, for: indexPath) as? DetailPhotoCell else {
//                return UITableViewCell()
//            }
            let cell = tableView.dequeueCell(indexPath) as DetailPhotoCell
            
            cell.update(product)
            return cell
        }
        
        if indexPath.row == 1 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseID, for: indexPath) as? DescriptionCell else {
//                return UITableViewCell()
//            }
            let cell = tableView.dequeueCell(indexPath) as DescriptionCell
            
            cell.update(product)
            return cell
        }
        
        if indexPath.row == 2 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ControlsCell.reuseID, for: indexPath) as? ControlsCell else {
//                return UITableViewCell()
//            }
            let cell = tableView.dequeueCell(indexPath) as ControlsCell
            
            cell.onDoughChanged =  { doughType in
                self.product?.doughType = doughType
            }
            
            cell.onSizeChanged = { size in
                self.product?.size = size
                self.setPrice()
            }
            
            return cell
        }
        
        if indexPath.row == 3 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsContainerCell.reuseID, for: indexPath) as? IngredientsContainerCell else {
//                return UITableViewCell()
//            }
            let cell = tableView.dequeueCell(indexPath) as IngredientsContainerCell
            cell.update(ingredients)
            
            cell.onIngredientItemSelected = { ingredients in
                self.selectedIngredients = ingredients
                self.setPrice()
            }
            
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

