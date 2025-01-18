//
//  ViewController.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import UIKit

enum MenuSections: Int, CaseIterable {
    case stories
    case banners
    case products
}

class MenuScreenVC: UIViewController {
    var productLoader: IProductsLoader
    var storiesLoader: IStoriesLoader
    var addressRepository: IAddressRepository
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var stories: [Story] = []
    var address: String?
    
    var onProductSelected: ((Product)->())?
    var onStorySelected: (([Story], IndexPath)->())?
    var onAddressTapped: (()->())?
        
    init(productsLoader: IProductsLoader, storiesLoader: IStoriesLoader, addressRepository: IAddressRepository) {
        
        self.productLoader = productsLoader
        self.storiesLoader = storiesLoader
        self.addressRepository = addressRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private var addressView: CurrentAddressView = {
        let addressView = CurrentAddressView()
        return addressView
    }()
    
    private lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
//        $0.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseID)
//        $0.register(BannerContainerCell.self, forCellReuseIdentifier: BannerContainerCell.reuseID)
//        $0.register(StoriesContainerCell.self, forCellReuseIdentifier: StoriesContainerCell.reuseID)
        $0.registerCell(ProductCell.self)
        $0.registerCell(BannerContainerCell.self)
        $0.registerCell(StoriesContainerCell.self)
        
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
        
        loadProducts()
        loadStories()
        loadAddressFromRepository()
        setupNotifications()
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: NSNotification.Name("addressUpdated"), object: nil)
    }
    
    func setupBindings() {
        addressView.onAdressButtonTapped = {
            self.navigateToAddressListScreen()
        }
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(addressUpdated), name: NSNotification.Name("addressUpdated"), object: nil)
    }
    
    @objc private func addressUpdated() {
        loadAddressFromRepository()
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
            case .stories:
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = MenuSections(rawValue: indexPath.section) {
            switch sectionType {
            case .banners:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerContainerCell.reuseID, for: indexPath) as? BannerContainerCell else {
//                    fatalError("Fatal error for cell at \(indexPath)")
//                }
                
                let cell = tableView.dequeueCell(indexPath) as BannerContainerCell
                
                cell.onBannerCellSelected = { product in
//                    let detailVC = di.screenFactory.makeDetailScreen()
//                    detailVC.update(product)
//                    self.present(detailVC, animated: true)
                    self.onProductSelected?(product)
                }
                
                cell.update(products)
                return cell
                
            case .products:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else {
//                    fatalError("Fatal error for cell at \(indexPath)")
//                }
                let cell = tableView.dequeueCell(indexPath) as ProductCell
                let product = products[indexPath.row]
                cell.update(product)
                return cell
                
            case .stories:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesContainerCell.reuseID, for: indexPath) as? StoriesContainerCell else {
//                    fatalError("Fatal error for cell at \(indexPath)")
//                }
                let cell = tableView.dequeueCell(indexPath) as StoriesContainerCell
                cell.update(stories)
                
                cell.onStoriesCellSelected = { indexPath in
//                    let storiesVC = di.screenFactory.makeStoriesScreen()
//                    self.present(storiesVC, animated: true)
//                    
//                    storiesVC.update(stories, indexPath)
                    self.onStorySelected?(self.stories, indexPath)
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        onProductSelected?(product)
//        let detailVC = di.screenFactory.makeDetailScreen()
//        detailVC.update(product)
//        present(detailVC, animated: true)
    }
}

//MARK: Navigation
extension MenuScreenVC {
    func navigateToAddressListScreen() {
//        let addressListVC = di.screenFactory.makeAddressListScreen()
//        present(addressListVC, animated: true)
//        
//        addressListVC.onDeliverToAddressButtonTapped = {
//            self.loadAddressFromRepository()
//        }
        onAddressTapped?()
    }
}

//MARK: Business logic
extension MenuScreenVC {
    private func loadProducts() {
        productLoader.loadProducts { [weak self] result in
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
    
    private func loadStories() {
        storiesLoader.loadStories { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let stories):
                DispatchQueue.main.async {
                    self.stories = stories
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadAddressFromRepository() {
        let addressList = addressRepository.retrieve()
        address = addressList.first { $0.isSelected }?.name
        addressView.updateAddressButton(address: address ?? "адрес", deliveryTime: "30 мин")
    }
    
}

//MARK: - Layout
extension MenuScreenVC {
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(addressView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addressView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            addressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            addressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            addressView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            addressView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
//            tableView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ])
    }
}

//#Preview(traits: .portrait) {
//   /// MenuScreenVC()
//}


