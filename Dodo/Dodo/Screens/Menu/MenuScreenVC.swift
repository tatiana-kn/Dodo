//
//  ViewController.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import UIKit

enum MenuSections: Int, CaseIterable {
    case banners
    case products
}
 
class MenuScreenVC: UIViewController {
//    let productService = ProductsService()
    var productLoader = ProductsLoader()
    
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
        $0.register(BannerContainerCell.self, forCellReuseIdentifier: BannerContainerCell.reuseID)

        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        loadProducts()
//        fetchProducts()
    }
    
//    private func fetchProducts() {
//        products = productService.fetchProduct()
//    }
}

//MARK: - Layout
extension MenuScreenVC {
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sectionType = MenuSections(rawValue: section) {
            switch sectionType {
            case .banners:
                return 1
            case .products:
                return products.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = MenuSections(rawValue: indexPath.section) {
            switch sectionType {
            case .banners:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerContainerCell.reuseID, for: indexPath) as? BannerContainerCell else {
                    fatalError("Fatal error for cell at \(indexPath)")
                }
                
                cell.onBannerCellSelected = { product in
                    //                    print("-> ", product)
                    //                    let detailVC = DetailScreenVC()
                    let detailVC = DetailConfigurator().configure()
                    detailVC.update(product)
                    self.present(detailVC, animated: true)
                }
                
                cell.update(products)
                return cell
                
            case .products:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else {
                    fatalError("Fatal error for cell at \(indexPath)")
                }
                let product = products[indexPath.row]
                cell.update(product)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        let detailVC = DetailConfigurator().configure()
//        let detailVC = DetailScreenVC()
        
//        detailVC.product = product
//        let detailVC = DetailScreenVC(product: product)
        
        detailVC.update(product)
        present(detailVC, animated: true)
    }
}

extension MenuScreenVC {
        private func loadProducts() {
            productLoader.loadUsers { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let products):
                    
                    DispatchQueue.main.async {
                        self.products = products
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
}

#Preview(traits: .portrait) {
    MenuScreenVC()
}
