//
//  CartScreenVC.swift
//  Dodo
//
//  Created by Tia M on 8/21/24.
//

import UIKit

final class CartScreenVC: UIViewController {
    
    var productsRepository: IProductsRepository
    var products: [Product] = []
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        tableView.registerCell(CartCell.self)
        tableView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return tableView
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить за", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(placeOrder), for: .touchUpInside)
        return button
    }()
    
    init(productsRepository: IProductsRepository) {
        self.productsRepository = productsRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProductsFromStorage()
    }

//    @objc private func handleCartUpdate() {
//        loadProductsFromStorage()
//    }
    
    @objc private func placeOrder() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Заказ принят",
            message: "Ваш заказ успешно принят и готовится. Спасибо за покупку!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension CartScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID, for: indexPath) as? CartCell else {
//            fatalError("Fatal error for cell at \(indexPath)")
//        }
        let cell = tableView.dequeueCell(indexPath) as CartCell
        let product = products[indexPath.row]
        cell.update(product)
        
            
        cell.onStepperValueChanged = { product in
            self.updateProductInStorage(product)
        }
        return cell
    }
}
//Business logic
extension CartScreenVC {
    
    func updateProductInStorage(_ product: Product) {
        self.productsRepository.update(product)
        loadProductsFromStorage()
    }
    
    func loadProductsFromStorage() {
        products = productsRepository.retrieve()
        tableView.reloadData()
        updatePrice()
    }
    
    func updatePrice() {
        var price = 0
        for product in products {
            price += (product.calculatedPrice ?? product.basePrice) * (product.count ?? 1)
        }
        orderButton.setTitle("Оформить за \(price) р.", for: .normal)
    }
}

extension CartScreenVC {
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(orderButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            tableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            orderButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            orderButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            orderButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

//#Preview(traits: .portrait) {
//    CartScreenVC()
//}
