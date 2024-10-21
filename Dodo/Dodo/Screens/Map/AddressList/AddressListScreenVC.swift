//
//  AddressListScreenVC.swift
//  Dodo
//
//  Created by Tia M on 10/18/24.
//

import UIKit

final class AddressListScreenVC: UIViewController {
    var addressList: [Address] = []
    
    private var headerView: AddressListHeaderView = {
        let headerView = AddressListHeaderView()
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.reuseID)
        return tableView
    }()
    
    private lazy var deliverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Доставить сюда", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deliverToAddress), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    @objc private func deliverToAddress(_ sender: UIButton) {
    }
    
    func setupBindings() {
        headerView.onNewAddressButtonTapped = {
            self.navigateToMapScreenVC()
        }
    }
}

extension AddressListScreenVC {
    func navigateToMapScreenVC() {
        let mapVC = MapScreenVC()
        let navigationController = UINavigationController(rootViewController: mapVC)
        present(navigationController, animated: true)
        //        present(mapVC, animated: true)
    }
}

extension AddressListScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
//        addressList?.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return UITableViewCell()
        }
//        let address = addressList[indexPath.row]
//        cell.update(address)
        return cell
    }
}

extension AddressListScreenVC {
    private func setupViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(deliverButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        deliverButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            deliverButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            deliverButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            deliverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            deliverButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

