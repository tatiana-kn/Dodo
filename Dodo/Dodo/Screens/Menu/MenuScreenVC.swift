//
//  ViewController.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import UIKit

class MenuScreenVC: UIViewController {
    let productService = ProductsService()
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseID)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchProducts()
    }
    
    private func fetchProducts() {
        products = productService.fetchProduct()
    }
}

//MARK: - Layout
extension MenuScreenVC {
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - UITableViewDataSource
extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else {
            fatalError("Fatal error for cell at \(indexPath)")
        }
        let product = products[indexPath.row]
        cell.update(product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        
        let detailVC = DetailScreenVC()
        
//        detailVC.product = product
        
//        let detailVC = DetailScreenVC(product: product)
        
        detailVC.update(product)
        
        present(detailVC, animated: true)
    }
}

#Preview(traits: .portrait) {
    MenuScreenVC()
}
