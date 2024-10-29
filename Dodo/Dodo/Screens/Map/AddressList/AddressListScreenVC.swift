//
//  AddressListScreenVC.swift
//  Dodo
//
//  Created by Tia M on 10/18/24.
//

import UIKit

final class AddressListScreenVC: UIViewController {
    var addressRepository = AddressRepository()
    
    var onDeliverToAddressButtonTapped: (() -> Void)?
//    var onAddressCellSelected: ((Address) -> Void)?
    
    var addressList: [Address] = []
    
    var currentAddress: Address?
    
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
        loadAddressListFromRepository()
    }
    
    @objc private func deliverToAddress(_ sender: UIButton) {
        guard let currentAddress else { return }
        for index in 0..<addressList.count {
            addressList[index].isSelected = (addressList[index] == currentAddress)
        }
//        addressRepository.setCurrentAddress(currentAddress)
//        loadAddressListFromRepository()
        addressRepository.updateAddressList(addressList)
        dismiss(animated: true, completion: nil)
        onDeliverToAddressButtonTapped?()
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
        
        mapVC.onAddressSaved = { [weak self] in
            self?.loadAddressListFromRepository()
        }
        
        let navigationController = UINavigationController(rootViewController: mapVC)
        present(navigationController, animated: true)
        //        present(mapVC, animated: true)
    }
    
    func navigateToEditMapScreenVC(with address: Address) {
        let mapVC = MapScreenVC()
        mapVC.address = address
        
        mapVC.onAddressSaved = { [weak self] in
            self?.loadAddressListFromRepository()
        }
        
        let navigationController = UINavigationController(rootViewController: mapVC)
        present(navigationController, animated: true)
        //        present(mapVC, animated: true)
    }
}

extension AddressListScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return UITableViewCell()
        }
        let address = addressList[indexPath.row]
        
//        let isSelected = indexPath.row == 0 ? true : false
//        if indexPath.row == 0 {
//            cell.update(address, true)
//        } else {
        //}

        let isSelected = address == currentAddress
        cell.update(address, isSelected)
        
        cell.onEditButtonTapped = {
            self.navigateToEditMapScreenVC(with: address)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addressList[indexPath.row]
        currentAddress = address
        tableView.reloadData()
        
//        for index in 0..<addressList.count {
//            if addressList[index] == address {
//                addressList[index].isSelected = true
//            } else {
//                addressList[index].isSelected = false
//            }
//        }
    }
}

extension AddressListScreenVC {
    func loadAddressListFromRepository() {
        addressList = addressRepository.retrieve()
        currentAddress = addressList.first { $0.isSelected }
        tableView.reloadData()
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

